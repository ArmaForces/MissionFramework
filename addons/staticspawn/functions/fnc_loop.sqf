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
	["_logic", objNull]
];
if (_logic isEqualTo objNull) exitWith {};
private _groups = _logic getVariable [QGVAR(groups), []];
if (_groups isEqualTo []) exitWith {
	_logic setVariable ["active", false];
};

private _checkBuildings = _logic getVariable [QGVAR(checkBuildings), true];
private _executionCodeUnit = _logic getVariable [QGVAR(executionCodeUnit), {}];
private _executionCodeGroup = _logic getVariable [QGVAR(executionCodeGroup), {}];

private _checkedUnits = 0;

{
	_x params ["_groupID", "_side", "_units", ["_group", grpNull]];
	
	// just break the loop, continue it on next frame
	if (_units isEqualTo []) exitWith {
		_groups deleteAt _forEachIndex;
	};

	// create group when not present
	if (_group isEqualTo grpNull) then {
		_group = createGroup [_side, true];
		_x set [3, _group];
		[_group] call _executionCodeGroup;
	};

	private _unitsPerFrame = count _units / diag_fpsMin;
	private _maxUnits = ceil _unitsPerFrame min count _units min 10;

	for "_i" from 1 to _maxUnits do {
		private _unit = objNull;
		private _unitArray = _units deleteAt 0;
		_unitArray params [
			"_type",
			"_loadout",
			"_pos",
			"_dir",
			"_stance",
			"_disabledAiFeatures",
			"_vehicleArray",
			"_building",
			"_buildingStatus",
			"_sphereSizeUnit",
			"_sphereBackDistanceUnit",
			"_sphereDespawnDistanceUnit",
			"_checkVisibilityUnit",
			"_forceSpawnDistanceUnit"
		];
		private _spherePos = _pos getPos [_sphereSizeUnit - _sphereBackDistanceUnit, _dir];
		private _spherePosASL = ATLtoASL _spherePos;
		_spherePosASL set [2, (ATLtoASL _pos) select 2];
		_spherePos = ASLToATL _spherePosASL;
		private _nearplayers = _spherePos nearEntities ["allVehicles", _sphereSizeUnit];
		private _playerIndex = -1;
		if (_checkVisibilityUnit) then {
			private _eyePosCheck = (ATLToASL _pos) vectorAdd [0,0,1.35 + random 0.35];
			_playerIndex = _nearplayers findIf {
				isPlayer _x && {
				!(vehicle _x isKindOf "AIR") && {
				([_x, "VIEW"] checkVisibility [_eyePosCheck, eyepos _x]) > 0
			}}};
			if (_playerIndex == -1) then {
				private _sphereSizeForce = (_sphereSizeUnit * _forceSpawnDistanceUnit) max _sphereBackDistanceUnit*2;
				private _spherePosForce = _pos getPos [_sphereSizeForce - _sphereBackDistanceUnit, _dir];
				private _spherePosASLForce = ATLtoASL _spherePosForce;
				_spherePosASLForce set [2, (ATLtoASL _pos) select 2];
				_spherePosForce = ASLToATL _spherePosASLForce;
				private _nearplayers = _spherePosForce nearEntities ["allVehicles", _sphereSizeForce];
				_playerIndex = _nearplayers findIf {isPlayer _x && {!(vehicle _x isKindOf "AIR")}};
			};
		} else {
			_playerIndex = _nearplayers findIf {isPlayer _x && {!(vehicle _x isKindOf "AIR")}};
		};
		if (_playerIndex != -1) then {
			if !(_vehicleArray isEqualTo []) then {
				_vehicleArray params ["_vehicle", "_role", "_cargoIndex", "_vehicleIndex"];
				if (alive _vehicle) then {
					// check if vehicle is static and _checkBuildings option is set
					if (
						_checkBuildings && {
						_vehicle isKindOf "StaticWeapon" &&
						{!(alive _building isEqualTo _buildingStatus)}
					}) exitWith {systemChat "MAI_fnc_staticSpawnInterval exitWith"};
					_unit = [_group, _type, _pos, _dir, 0, false] call MAI_fnc_spawnAI;
					_group addVehicle _vehicle;
					[_unit, _vehicle, _role, _cargoIndex] call MAI_fnc_moveInVehicleRole;
				};
			} else {
				if (!_checkBuildings || alive _building isEqualTo _buildingStatus) then {
					_unit = [_group, _type, _pos, _dir] call MAI_fnc_spawnAI;
					_unit setUnitPos _stance;
				};
			};
		} else {
			_units pushBack _unitArray;
		};

		if !(_unit isEqualTo objNull) then {
			_unit setVariable [QGVAR(unitArray), _unitArray];
			_unit setVariable [QGVAR(groupID), _groupID];
			_unit setVariable [QGVAR(side), _side];
			_unit setVariable [QGVAR(logic), _logic];
			[_unit] call FUNC(despawnLoop);
			_checkedUnits = _checkedUnits + 1;
			_unit setUnitLoadout _loadout;

			[_unit, "PATH"] remoteExecCall ["disableAI", 0, _unit];
			{
				[_unit, _x] remoteExecCall ["disableAI", 0, _unit];
			} forEach _disabledAiFeatures;

			[_unit] call _executionCodeUnit;
		};
	};

} forEach _groups;

_logic setVariable [QGVAR(groups), _groups];

[
	{
		_this call FUNC(loop);
	},
	_this,
	0
] call CBA_fnc_waitAndExecute;

Nil