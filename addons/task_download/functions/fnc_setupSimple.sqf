#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function sets up given object as a download source.
 * This is a simple version that works on a fixed time basis and minimalizes network traffic.
 *
 * Arguments:
 * 0: Object that will have download action added <OBJECT>
 * 1: Time it will take for the download to finish <NUMBER>
 * 2: Size of the download <NUMBER>
 *
 * Return Value:
 * Set up finished correctly <BOOL>
 *
 * Example:
 * [laptop, 66, 2096] call afmf_task_download_fnc_setupSimple
 *
 * Public: Yes
 */

params [
    "_object",
    "_downloadTime",
    "_downloadSize"
];

TRACE_3("Setup simple download",_object,_downloadTime,_downloadSize);

if (isNil "_downloadTime" || isNil "_downloadSize") exitWith { false };
if (!([_object] call FUNC(canContinue))) exitWith { false };

if (isServer) then {
    _object setVariable [QGVAR(initialized), true, true];
    _object setVariable [QGVAR(downloadTime), _downloadTime, true];

    // For display progress on screen
    _object setVariable [QGVAR(downloadStarted), false, true];
    _object setVariable [QGVAR(downloadInProgress), false, true];
    _object setVariable [QGVAR(downloadFinished), false, true];
    _object setVariable [QGVAR(deviceUnplugged), false, true];

    private _progressPerTick = MAX_PROGRESS / (_downloadTime / PROGRESS_INTERVAL);
    _object setVariable [QGVAR(downloadProgressPerTick), _progressPerTick, true];
};

// Create action
if (hasInterface) then {
    _object setVariable [QGVAR(downloadIntel_prepareFinished_client), false];
    _object setVariable [QGVAR(downloadIntel_prepareStage_client), 0];

    [_object] call FUNC(initDownloadAction);
    [_object] call FUNC(initGetDeviceAction);
    [_object, 0, _downloadSize, _downloadTime] call FUNC(prepareDisplay);
};

true
