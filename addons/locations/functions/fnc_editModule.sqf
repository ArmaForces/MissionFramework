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
private _hide = GET_ATTR(hide);

TRACE_3("editModule",_module,_name,_hide);

private _location = createLocation [NEAREST_LOCATION(_module)];

if (_name != "") then {
    _location setText GET_ATTR(name);
};

if (_hide) then {
    if (is3DEN) exitWith {
        _location setText format ["%1 (%2)", _module getVariable QGVAR(defaultName), LLSTRING(Hidden)];
    };
    _location setType "Invisible";
} else {
    if (is3DEN && {_name == ""}) exitWith {
        _location setText (_module getVariable QGVAR(defaultName));
    };
};
