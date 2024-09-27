#include "script_component.hpp"
/*
 * Author: veteran29
 * Initialization function of Edit Location module.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define GET_ATTR(ATTR) (_module getVariable QGVAR(ATTR))

if (canSuspend) exitWith {
    [LINKFUNC(editModule), _this] call CBA_fnc_directCall;
};

params ["_module"];

private _name = GET_ATTR(name);

TRACE_2("editModule",_module,_name);

if (_name != "") then {
    private _location = createLocation [NEAREST_LOCATION(_module)];
    _location setText GET_ATTR(name);
};
