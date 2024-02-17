#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Starts the download loop.
 * Notifies player who started the download about estimated finish time.
 *
 * Arguments:
 * 0: Object which is used for the download <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

#define RETURN_ARRAY true

params ["_object", "_player"];

private _startCondition = _object getVariable [QGVAR(startCondition), FUNC(canContinue)];
private _canStart = [_object] call _startCondition;
if (!_canStart) exitWith {
    private _msg = _object getVariable [QGVAR(startFailedMessage), ""];
    [QGVAR(startFailed), [_msg], _player] call CBA_fnc_targetEvent;
};

_object setVariable [QGVAR(downloadStarted), true, true];

private _totalExpectedTime = _object getVariable [QGVAR(downloadTime), 0];
private _progressPerTick = MAX_PROGRESS / (_totalExpectedTime / PROGRESS_INTERVAL);

[FUNC(loop), [_object, _progressPerTick]] call CBA_fnc_execNextFrame;

// Show estimated time left to a player who started the download
private _expectedRemainingTimeText = [_totalExpectedTime] call FUNC(calculateEstimatedTimeRemaining);

[QGVAR(startSuccessful), [_expectedRemainingTimeText], _player] call CBA_fnc_targetEvent;

[QGVAR(initCheckProgressAction), [_object]] call CBA_fnc_globalEventJIP;

// Invoke public event
[QGVAR(started), [_object]] call CBA_fnc_globalEvent;

nil
