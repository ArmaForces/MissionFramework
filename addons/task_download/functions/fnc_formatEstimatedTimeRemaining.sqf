#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Formats remaining estimated time as a formatted string.
 *
 * Arguments:
 * 0: Total expected time of the download <OBJECT>
 * 1: Current download progress <NUMBER> (Optional, default 0)
 *
 * Return Value:
 * Formatted time <STRING>
 *
 * Example:
 * [60, 50] call afmf_task_download_fnc_formatEstimatedTimeRemaining
 *
 * Public: No
 */

#define RETURN_ARRAY true

params ["_totalExpectedTime", ["_currentProgress", INITIAL_PROGRESS]];

if (_currentProgress isEqualTo INITIAL_PROGRESS) exitWith { "Unknown" };

private _timeLeft = _totalExpectedTime - _totalExpectedTime * (_currentProgress/100);

private _timeLeftArray = [_timeLeft, "HH:MM:SS", RETURN_ARRAY] call BIS_fnc_secondsToString;

_timeLeftArray params ["_hours", "_minutes", "_seconds"];
private _expectedRemainingTimeText = if (_hours isEqualTo "00") then {
    if (_minutes isEqualTo "00") then {
        private _value = [_seconds, "0"] call CBA_fnc_leftTrim;
        if (_value isEqualTo "") then { _value = "0" };
        format ["%1 s", _value]
    } else {
        private _value = [_minutes, "0"] call CBA_fnc_leftTrim;
        format ["%1 min", _value]
    };
} else {
    private _value = [_hours, "0"] call CBA_fnc_leftTrim;
    format ["%1 h", _value]
};

_expectedRemainingTimeText
