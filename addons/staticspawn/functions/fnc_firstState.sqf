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
_logic setVariable ["activationTriggers", _activationTriggers];
_logic setVariable ["groups", _groups];
_logic setVariable ["includeAir", _includeAir];
_logic setVariable ["forceActivate", _forceActivate];
_logic setVariable ["checkBuildings", _checkBuildings];
_logic setVariable ["activateCondition", _activateCondition];
_logic setVariable ["executionCodeUnit", _executionCodeUnit];
_logic setVariable ["executionCodePatrol", _executionCodeGroup];

[_logic] call FUNC(interval);