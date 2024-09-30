#include "script_component.hpp"
/*
 * Author: veteran29
 * Update location attached to the module. For 3DEN.
 *
 * Arguments:
 * 0: Module <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_module"];

private _nearestLocation = NEAREST_LOCATION(_module);
private _previousLocation = _module getVariable [QGVAR(location3DEN), locationNull];

TRACE_2("updateLocation",_nearestLocation,_previousLocation);

// if we moved the module to another location, restore the name of previous location
if (_nearestLocation isNotEqualTo _previousLocation) then {
    // restore original text
    _previousLocation setText (_module getVariable QGVAR(defaultName));
    _previousLocation setType (_module getVariable QGVAR(defaultType));

    _module setVariable [QGVAR(location3DEN), _nearestLocation];
    _module setVariable [QGVAR(defaultName), text _nearestLocation];
    _module setVariable [QGVAR(defaultType), type _nearestLocation];
};

_module set3DENAttribute [QGVAR(location), text _nearestLocation];

[_module] call FUNC(editModule);
