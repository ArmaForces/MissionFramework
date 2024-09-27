#include "script_component.hpp"
/*
 * Author: veteran29
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

params ["_module"];

private _nearestLocation = NEAREST_LOCATION(_module);
private _previousLocation = _module getVariable [QGVAR(location3DEN), locationNull];

TRACE_2("updateLocation",_nearestLocation,typeName _previousLocation);

// if we moved the module to another location, restore the name of previous location
if (_nearestLocation isNotEqualTo _previousLocation) then {
    // restore original text
    _previousLocation setText (_module getVariable QGVAR(defaultName));

    _module setVariable [QGVAR(location3DEN), _nearestLocation];
    _module setVariable [QGVAR(defaultName), text _nearestLocation];
};

_module set3DENAttribute [QGVAR(location), text _nearestLocation];

[_module] call FUNC(editModule);
