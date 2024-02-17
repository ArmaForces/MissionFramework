#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function sets up given object as a download source.
 *
 * Arguments:
 * 0: Object that will have download action added <OBJECT>
 * 1: Time it will take for the download to finish <NUMBER>
 * 2: Condition that must be fulfilled for the download to start when action is used <FUNC> (Optional)
 * 3: Message that will be shown to player starting the download if the download couldn't start <STRING> (Optional)
 *
 * Return Value:
 * Set up finished correctly <BOOL>
 *
 * Example:
 * [laptop] call afmf_task_download_fnc_setup
 *
 * Public: No
 */

params [
    "_object",
    "_downloadTime",
    ["_startCondition", FUNC(canContinue)],
    ["_startFailedMessage", LSTRING(StartActionFailed)]
];

if (!([_object] call FUNC(canContinue))) exitWith { false };
if (_object getVariable [QGVAR(initialized), false]) exitWith { false };
if (_object getVariable [QGVAR(downloadStarted), false]) exitWith { false };

_object setVariable [QGVAR(initialized), true];
_object setVariable [QGVAR(downloadTime), _downloadTime];
_object setVariable [QGVAR(startCondition), _startCondition];
_object setVariable [QGVAR(startFailedMessage), _startFailedMessage];

private _showCondition = {
    params ["_object"];
    !(_object getVariable [QGVAR(downloadStarted), false])
};

private _action = [
    QGVAR(startDownloadAction),
    LLSTRING(StartAction),
    "",
    {
        params ["_object"];
        [QGVAR(start), [_object, player]] call CBA_fnc_serverEvent;
    },
    _showCondition,
    {}, [_object], "", 4, [false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;

private _actionPath = [
    _object,
    ACTION_TYPE,
    ["ACE_MainActions"],
    _action
] call ACEFUNC(interact_menu,addActionToObject);

_object setVariable [QGVAR(actionPath), _actionPath];

true
