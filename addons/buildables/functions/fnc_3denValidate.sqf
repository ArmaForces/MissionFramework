#include "script_component.hpp"
/*
 * Author: veteran29
 * Validate modules configuration in 3DEN editor.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_logic"];

private _logicLayer = _logic get3DENAttribute QGVAR(layer) select 0;

if (_logicLayer == "") exitWith {
    [LLSTRING(3DEN_Error_Layer), 1, 5] call BIS_fnc_3DENNotification;
};

private _modules = allMissionObjects QGVAR(areaModule) - [_logic];
private _duplicateIdx = _modules findIf {_x get3DENAttribute QGVAR(layer) isEqualTo [_logicLayer]};
if (_duplicateIdx != -1) exitWith {
    GVAR(3denLogic) = _logic;
    private _duplicate = _modules select _duplicateIdx;
    private _duplicateName = _duplicate get3DENAttribute "Name" select 0;
    _duplicateName = [_duplicateName, str _duplicate] select (_duplicateName == "");

    [
        format [LLSTRING(3DEN_Duplicate_Layer), _duplicateName],
        localize "STR_MIS_STATE_ERROR",
        [
            "OK",
            {
                // spawn to prevent crash
                GVAR(3denLogic) spawn {
                    set3DENSelected [_this];
                    do3DENAction "OpenAttributes";
                };
                GVAR(3denLogic) = nil;
            }
        ]
    ] call BIS_fnc_3DENShowMessage;

    _logic set3DENAttribute [QGVAR(layer), ""];
};

nil
