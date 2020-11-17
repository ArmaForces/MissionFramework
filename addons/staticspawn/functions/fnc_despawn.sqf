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

params [["_unit", objNull], ["_logic", objNull], ["_unitArray", []]];
private _groupID = _unit getVariable [QGVAR(groupID), -1];
private _groups = _logic getVariable [QGVAR(groups), []];
private _side = _unit getVariable [QGVAR(AF_side), side _unit];
private _active = _logic getVariable [QGVAR(active), true];
private _group = group _unit;
deleteVehicle _unit;
if (_groups isEqualTo []) exitWith {
	_groups pushBack [_groupID, _side, [_unitArray], group _unit];
	if !(_active) then {
		_logic setVariable [QGVAR(active), true];
		_logic call FUNC(loop);
	};
};
private _groupIndex = _groups findIf {_x select 0 isEqualTo _groupID};
if (_groupIndex isEqualTo -1) exitWith {
	_groups pushBack [_groupID, _side, [_unitArray], group _unit];
	if !(_active) then {
		_logic setVariable [QGVAR(active), true];
		_logic call FUNC(loop);
	};
};
private _groupArray = _groups select _groupIndex;
_groupArray params ["_groupID", "_side", "_units", ["_group", grpNull]];
_units pushBack _unitArray;
