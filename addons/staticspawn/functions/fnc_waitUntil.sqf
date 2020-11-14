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
	
	private _activationTriggers = _logic getVariable ["MAI_activationTriggers" ,[]];
	private _includeAir = _logic getVariable ["MAI_includeAir", false];
	private _forceActivate = _logic getVariable ["MAI_forceActivate", false];
	private _checkBuildings = _logic getVariable ["MAI_checkBuildings", true];
	private _activateCondition = _logic getVariable ["MAI_activateCondition", {true}];
	private _executionCodeUnit = _logic getVariable ["MAI_executionCodeUnit", {}];
	private _executionCodeGroup = _logic getVariable ["MAI_executionCodeGroup", {}];

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
	] remoteExecCall ["MAI_fnc_staticSpawnFirstState",_owner,false];
} else {
	[{_this call FUNC(WaitUntil)},
	_this,
	random [0.9,1,1.1]
	] call CBA_fnc_waitAndExecute;
};

Nil