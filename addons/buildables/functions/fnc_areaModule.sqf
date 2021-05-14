#include "script_component.hpp"
/*
 * Author: veteran29
 * Initialization function of Buildable Area module.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define GET_ATTR(ATTR) private _##ATTR = _logic getVariable QGVAR(ATTR)

if (canSuspend) exitWith {
    [LINKFUNC(areaModule), _this] call CBA_fnc_directCall;
};

params [
    ["_logic", objNull, [objNull]]
];

private _area = [getPosASL _logic];
_area append (_logic getVariable ["objectarea", []]);

GET_ATTR(layer);
GET_ATTR(supplyCrates);

systemChat str [_area, _layer, _supplyCrates];
