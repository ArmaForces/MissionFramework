#include "script_component.hpp"
/*
 * Author: veteran29
 * Function description
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: State <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [lamp, "ON"] call afmf_lights_fnc_switchLight
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(switchLight), _this] call CBA_fnc_serverEvent // return
};

params [
    ["_object", objNull, [objNull]],
    ["_state", "AUTO", [""]]
];

private _jipId = format [QGVAR(switchLightId_%1), _object call BIS_fnc_netId];

TRACE_3("Switching light state",_object,_state,_jipId);

[QGVAR(switchLightLocal), [_object, _state], _jipId] call CBA_fnc_globalEventJIP;

if !(_object getVariable [_jipId, false]) then {
    _object setVariable [_jipId, true];

    TRACE_2("Adding jip event delete",_object,_jipId);
    [_jipId, _object] call CBA_fnc_removeGlobalEventJIP;
};

nil // return
