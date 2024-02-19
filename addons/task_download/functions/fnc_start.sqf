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

#define PREPARATION_TIME 20

params ["_object", "_player"];

if (!isServer) exitWith {};

private _startCondition = _object getVariable [QGVAR(startCondition), FUNC(canContinue)];
private _canStart = [_object] call _startCondition;
if (!_canStart) exitWith {
    private _msg = _object getVariable [QGVAR(startFailedMessage), ""];
    [QGVAR(startFailed), [_msg], _player] call CBA_fnc_targetEvent;
};

private _totalDownloadTime = _object getVariable [QGVAR(downloadTime), 0];
private _downloadStartTime = CBA_missionTime + PREPARATION_DURATION;
private _timeToDownloadEnd = _totalDownloadTime + PREPARATION_DURATION;

_object setVariable [QGVAR(downloadStarted), true, true];
_object setVariable [QGVAR(downloadInProgress), true, true];
_object setVariable [QGVAR(downloadStartTime), _downloadStartTime, true];

[{!([_this select 0] call FUNC(canContinue))}, {
    // Download interrupted
    params ["_object"];
    [QGVAR(failed)] call CBA_fnc_globalEvent;
}, [_object], _timeToDownloadEnd, {
    // Download finished
    params ["_object"];
    _object setVariable [QGVAR(downloadFinished), true, true];
    _object setVariable [QGVAR(downloadInProgress), false, true];
}] call CBA_fnc_waitUntilAndExecute;

// Invoke public event
[QGVAR(started), [_object]] call CBA_fnc_globalEvent;

nil
