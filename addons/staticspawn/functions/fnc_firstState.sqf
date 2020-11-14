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
_logic setVariable ["MAI_activationTriggers", _activationTriggers];
_logic setVariable ["MAI_groups", _groups];
_logic setVariable ["MAI_includeAir", _includeAir];
_logic setVariable ["MAI_forceActivate", _forceActivate];
_logic setVariable ["MAI_checkBuildings", _checkBuildings];
_logic setVariable ["MAI_activateCondition", _activateCondition];
_logic setVariable ["MAI_executionCodeUnit", _executionCodeUnit];
_logic setVariable ["MAI_executionCodePatrol", _executionCodeGroup];

[_logic] call FUNC(interval);