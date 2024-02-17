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
private _timeLeft = [_totalExpectedTime, "HH:MM:SS", RETURN_ARRAY] call BIS_fnc_secondsToString;

_timeLeft params ["_hours", "_minutes", "_seconds"];
private _expectedRemainingTimeText = if (_hours isEqualTo "00") then {
    if (_minutes isEqualTo "00") then {
        private _value = [_seconds, "0"] call CBA_fnc_leftTrim;
        format ["%1 sec", _value]
    } else {
        private _value = [_minutes, "0"] call CBA_fnc_leftTrim;
        format ["%1 min", _value]
    };
} else {
    private _value = [_hours, "0"] call CBA_fnc_leftTrim;
    format ["%1 h", _value]
};

[QGVAR(startSuccessful), [_expectedRemainingTimeText], _player] call CBA_fnc_targetEvent;

// Invoke public event
[QGVAR(started), [_object]] call CBA_fnc_globalEvent;

nil
