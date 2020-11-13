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

if (!isServer) exitWith {
	diag_log text "[MAI_fnc_staticSpawnInit] script intended to be only used on server, exit.";
};
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];

private _synchronizedObjects = synchronizedObjects _logic;

if (_synchronizedObjects isEqualTo []) exitWith {
	(format ["[%1] STATIC SPAWN - No units synchronized!", _logic]) call BIS_fnc_error;
};

_activationTriggers = [];
private _groupSync = [];
{
	if (_x isKindOf "EmptyDetector") then {
		_activationTriggers pushBack _x;
	}else{
		if (_x isKindOf "Man") then {
			_groupSync pushBackUnique group _x;
		};
	};
} forEach _synchronizedObjects;

_logic setVariable ["activationTriggers",_activationTriggers];

private _groupsArray = [_groupSync, _logic] call FUNC(getGroups);
_groupsArray params ["_groups", "_vehiclesInfo"];
_logic setVariable ["vehiclesInfo", _vehiclesInfo];

/*
private _deleteVehicles = _logic getVariable ["deleteVehicles", false];
if (_deleteVehicles) then {
	{deleteVehicle _x} forEach _vehiclesToDelete;
};
*/

_logic setVariable ["groups", _groups];

[
	{_this call FUNC(WaitUntil)},
	[_logic],
	1
]call CBA_fnc_waitAndExecute;

Nil