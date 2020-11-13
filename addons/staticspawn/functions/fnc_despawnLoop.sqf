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

params [["_unit", objNull]];
if (!alive _unit) exitWith {};
private _logic = _unit getVariable ["MAI_logic", objNull];
if (!alive _logic) exitWith {};
_unitArray = _unit getVariable ["MAI_unitArray", []];
if (_unitArray isEqualTo []) exitWith {};
_unitArray params ["_type", "_loadout", "_pos", "_dir", "_stance", "_disabledAiFeatures", "_vehicleArray", "_building", "_buildingStatus", "_sphereSizeUnit", "_sphereBackDistanceUnit", "_sphereDespawnDistanceUnit"];
if (_sphereDespawnDistanceUnit < 0) exitWith {};
private _spherePos = _pos getPos [_sphereSizeUnit - _sphereBackDistanceUnit + _sphereDespawnDistanceUnit*0.9, _dir];
private _nearplayers = _spherePos nearEntities ["allVehicles", _sphereSizeUnit + _sphereDespawnDistanceUnit];
private _playerIndex = _nearplayers findIf {isPlayer _x && !(vehicle _x isKindOf "AIR")};
// despawn unit
if (_playerIndex == -1) then {
	[_unit, _logic, _unitArray] call FUNC(despawn);
	private _active = _logic getVariable ["active", true];
	if !(_active) then {
		[_logic] call MAI_fnc_staticSpawnInterval;
	};
} else {
	[
		{
			_this call FUNC(despawnLoop);
		},
		_this,
		0.75 + random 0.5
	] call CBA_fnc_waitAndExecute;
};