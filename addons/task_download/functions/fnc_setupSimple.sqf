#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function sets up given object as a download source.
 * This is a simple version that works on a fixed time basis and minimalizes network traffic.
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
 * [laptop] call afmf_task_download_fnc_setupSimple
 *
 * Public: Yes
 */

params [
    "_object",
    "_downloadTime",
    ["_downloadSize", 2137],
    ["_startCondition", FUNC(canContinue)],
    ["_startFailedMessage", LSTRING(StartActionFailed)]
];

if (!([_object] call FUNC(canContinue))) exitWith { false };

if (isServer) then {
    _object setVariable [QGVAR(initialized), true, true];
    _object setVariable [QGVAR(downloadTime), _downloadTime];
    _object setVariable [QGVAR(startCondition), _startCondition];
    _object setVariable [QGVAR(startFailedMessage), _startFailedMessage];

    // For display progress on screen
    _object setVariable [QGVAR(lastLoginDate), call FUNC(randomDateTime), true];
    _object setVariable [QGVAR(downloadStarted), false, true];
    _object setVariable [QGVAR(downloadInProgress), false, true];
    _object setVariable [QGVAR(downloadFinished), false, true];

    private _progressPerTick = MAX_PROGRESS / (_downloadTime / PROGRESS_INTERVAL);
    _object setVariable [QGVAR(downloadProgressPerTick), _progressPerTick, true];
};

// Create action
if (hasInterface) then {
    _object setVariable [QGVAR(downloadIntel_prepareFinished_client), false];
    _object setVariable [QGVAR(downloadIntel_prepareStage_client), 0];

    [_object] call FUNC(initDownloadAction);
    [_object] call FUNC(initGetPendriveAction);
    [_object, 0, _downloadSize, _downloadTime] call FUNC(prepareDisplay);
};

true
