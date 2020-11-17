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

params [["_logic",objNull]];

if (_logic isEqualTo objNull) exitWith {};

//private _activate = [_logic] call MAI_fnc_checkActivateConditions;
_activate = true; // for testing, function above needs to be rewriten

if (_activate) then {
	private _groups = _logic getVariable ["groups", []];

	if (!isServer && !hasInterface) exitWith {
		[_logic, _groups] call FUNC(staticspawnInterval);
	};
	
	private _activationTriggers = _logic getVariable [QGVAR(activationTriggers) ,[]];
	private _includeAir = _logic getVariable [QGVAR(includeAir), false];
	private _forceActivate = _logic getVariable [QGVAR(forceActivate), false];
	private _checkBuildings = _logic getVariable [QGVAR(checkBuildings), true];
	private _activateCondition = _logic getVariable [QGVAR(activateCondition), {true}];
	private _executionCodeUnit = _logic getVariable [QGVAR(executionCodeUnit), {}];
	private _executionCodeGroup = _logic getVariable [QGVAR(executionCodeGroup), {}];

	private _owner = call MAI_fnc_HCfind;
	[
		_logic,
		_activationTriggers,
		_groups,
		_includeAir,
		_forceActivate,
		_checkBuildings,
		_activateCondition,
		_executionCodeUnit,
		_executionCodeGroup
	] remoteExecCall [QFUNC(firstState),_owner,false];
} else {
	[{_this call QFUNC(WaitUntil)},
	_this,
	random [0.9,1,1.1]
	] call CBA_fnc_waitAndExecute;
};

Nil