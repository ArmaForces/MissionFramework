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
	["_logic", objNull],
	["_activationTriggers", []],
	["_groups", []],
	["_includeAir", false],
	["_forceActivate", true],
	["_checkBuildings", true],
	["_activateCondition", {true}],
	["_executionCodeUnit", {}],
	["_executionCodeGroup", {}]
];

if (_logic isEqualTo objNull) exitWith {};
_logic setVariable [QGVAR(activationTriggers), _activationTriggers];
_logic setVariable [QGVAR(groups), _groups];
_logic setVariable [QGVAR(includeAir), _includeAir];
_logic setVariable [QGVAR(forceActivate), _forceActivate];
_logic setVariable [QGVAR(checkBuildings), _checkBuildings];
_logic setVariable [QGVAR(activateCondition), _activateCondition];
_logic setVariable [QGVAR(executionCodeUnit), _executionCodeUnit];
_logic setVariable [QGVAR(executionCodePatrol), _executionCodeGroup];

[_logic] call FUNC(loop);