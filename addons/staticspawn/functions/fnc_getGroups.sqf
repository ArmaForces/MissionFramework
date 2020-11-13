#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afmf_main_fnc_example
 *
 * Public: No
 */

params [
	["_groupsInput",[],[[]]], ["_logic", objNull, [objNull]]
];

private _sphereSize = _logic getVariable ["MAI_sphereSize", 250];
private _sphereBackDistance = _logic getVariable ["MAI_sphereBackDistance", 30];
private _sphereDespawnDistance = _logic getVariable ["MAI_sphereDespawnDistance", 50];
private _checkVisibility = _logic getVariable ["MAI_checkVisibility", true];
private _forceSpawnDistance = _logic getVariable ["MAI_forceSpawnDistance", 0.35];
private _groups = [];
private _vehiclesInfo = [];
//private _vehiclesToDelete = [];
{
	private _group = _x;
	private _leader = leader _group;

	private _side = side _x;
	//private _waypoints = [];
	private _behaviour = behaviour _leader;
	private _units = [];

	/*
	// waypoints
	{
		private _wPos = waypointPosition _x;
		// don't include "dummy" waypoint
		if (_forEachIndex > 0) then {
			private _wType = waypointType _x;
			private _wTimeout = waypointTimeout _x;
			private _behaviour = waypointBehaviour _x;
			_waypoints pushBack [_wPos, _wType, _wTimeout, _behaviour];
		};
	} forEach (waypoints _group);
	*/
	// units
	{
		private _unit = _x;
		if (alive _unit) then {
			private _type = typeOf _unit;
			private _loadout = getUnitLoadout _unit;
			private _pos = _unit modelToWorld [0, 0, 0];
			private _dir = getDir _unit;
			private _stance = unitPos _unit;
			if (_stance isEqualTo "AUTO") then {
				_stance = "UP"
			};

			private _disabledAiFeatures = [];
			{
				if !(_unit checkAIFeature _x) then {
					_disabledAiFeatures pushBack _x
				};
			}forEach [
				"TARGET",
				"AUTOTARGET",
				"MOVE",
				"ANIM",
				"TEAMSWITCH",
				"FSM",
				"WEAPONAIM",
				"AIMINGERROR",
				"SUPPRESSION",
				"CHECKVISIBLE",
				"COVER",
				"AUTOCOMBAT",
				"PATH",
				"MINEDETECTION",
				"NVG",
				"LIGHTS",
				"RADIOPROTOCOL"
			];

			private _vehicleArray = [];
			private _vehicle = vehicle _unit;
			if !(_vehicle isKindOf "MAN") then {
				private _vehicleRole = assignedVehicleRole _unit;
				private _vehicleIndex = -1;
				//_vehicleIndex = _vehiclesToDelete findIf {_x isEqualTo _vehicle};
				//if (_vehicleIndex == -1) then {
				private _vehInfo = _vehicle call MAI_fnc_getVehicleInfo;
				_vehiclesInfo pushBack _vehInfo;
				_vehicleIndex = count _vehiclesInfo - 1;
				//};
				private _assignedRole = assignedVehicleRole _unit;
				private _cargoIndex = _vehicle getCargoIndex _unit;
				_vehicleArray = [
					_vehicle,
					_assignedRole,
					_cargoIndex,
					_vehicleIndex
				];
			};

			// check if building above/below unit is "alive"
			// if true, do not spawn unit when that building will not be "alive"
			private _posASL = getposASL _unit;
			private _building = objNull;
			private _buildingStatus = false;
			private _objects = lineIntersectsWith [_posASL vectorAdd [0,0,0.5], _posASL vectorAdd [0,0,50], _unit, vehicle _unit, true];
			if (_objects isEqualTo []) then {
				_objects = lineIntersectsWith [_posASL vectorAdd [0,0,0.5], _posASL vectorAdd [0,0,-1.5], _unit, vehicle _unit, true];
			};
			if !(_objects isEqualTo [])then {
				private _object = _objects select 0;
				_building = _object;
				_buildingStatus = alive _object;
			};
			private _sphereSizeUnit = _unit getVariable ["MAI_sphereSize", _sphereSize];
			private _sphereBackDistanceUnit = _unit getVariable ["MAI_sphereBackDistance", _sphereBackDistance];
			private _sphereDespawnDistanceUnit = _unit getVariable ["MAI_sphereDespawnDistance", _sphereDespawnDistance];
			private _checkVisibilityUnit = _unit getVariable ["MAI_checkVisibility", _checkVisibility];
			private _forceSpawnDistanceUnit = _unit getVariable ["MAI_forceSpawnDistance", _forceSpawnDistance];
			_units pushBack [
				_type,
				_loadout,
				_pos,
				_dir,
				_stance,
				_disabledAiFeatures,
				_vehicleArray,
				_building,
				_buildingStatus,
				_sphereSizeUnit,
				_sphereBackDistanceUnit,
				_sphereDespawnDistanceUnit,
				_checkVisibilityUnit,
				_forceSpawnDistanceUnit
			];
		};
		deleteVehicle _unit;
	} forEach units _group;
	if !(_units isEqualTo []) then {
		_groups pushBack [_forEachIndex, _side, _units];
	};
	deleteGroup _group;
} forEach _groupsInput;

[_groups, _vehiclesInfo]