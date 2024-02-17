#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function sends current download progress to player.
 *
 * Arguments:
 * 0: Object which is used for download <OBJECT>
 * 1: Player who's checking progress <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [laptop, player] call afmf_task_download_fnc_checkProgress
 *
 * Public: No
 */

params ["_object", "_player"];

private _isCompleted = _object getVariable [QGVAR(completed), false];
if (_isCompleted) exitWith {
    [QGVAR(showProgressCompleted), [_object], _player] call CBA_fnc_targetEvent;

    if (GVAR(automaticCompletion)) exitWith {};

    private _confirmedCompletionEarlier = _object getVariable [QGVAR(completedConfirmed), false];
    if (_confirmedCompletionEarlier) exitWith {};
    _object setVariable [QGVAR(completedConfirmed), true, true];

    [QGVAR(successful), [_object]] call CBA_fnc_globalEvent;
};

private _currentProgress = _object getVariable [QGVAR(progress), INITIAL_PROGRESS];
private _totalTime = _object getVariable [QGVAR(downloadTime), 0];

private _estimatedTimeLeft = [_totalTime, _currentProgress] call FUNC(calculateEstimatedTimeRemaining);
private _progressText = [_currentProgress] call FUNC(formatProgress);

[QGVAR(showProgress), [_object, _progressText, _estimatedTimeLeft], _player] call CBA_fnc_targetEvent;
