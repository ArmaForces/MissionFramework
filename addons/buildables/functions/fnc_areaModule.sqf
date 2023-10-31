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

#define GET_ATTR(ATTR) (_logic getVariable QGVAR(ATTR))

if (canSuspend) exitWith {
    [LINKFUNC(areaModule), _this] call CBA_fnc_directCall;
};

params [
    ["_logic", objNull, [objNull]]
];

private _area = [ASLToAGL getPosASL _logic];
_area append (_logic getVariable ["objectarea", []]);
_logic setVariable [QGVAR(area), _area, true];

if (GET_ATTR(onBuilt) != '') then {
    [QGVAR(built), {
        params ["_layer"];
        _thisArgs params ["_targetLayer", "_callback"];
        if (_layer != _targetLayer) exitWith {};

        [_thisType, _thisId] call CBA_fnc_removeEventHandler;

        _this call _callback;

    }, [GET_ATTR(layer), compileFinal GET_ATTR(onBuilt)]] call CBA_fnc_addEventHandlerArgs;
};

[
    GET_ATTR(layer),
    _area,
    nil,
    GET_ATTR(requiredSupplies),
    GET_ATTR(buildTime),
    GET_ATTR(hideObjects),
    GET_ATTR(supplyCrates)
] call FUNC(areaInit);

nil
