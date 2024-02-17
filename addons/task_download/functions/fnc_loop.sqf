#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Tracks download progress.
 *
 * Arguments:
 * 0: Object which is used for the download <OBJECT>
 * 1: Progress per tick (loop) <NUMBER>
 * 2: Current progress <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_object", "_progressPerTick", ["_progress", INITIAL_PROGRESS]];

private _canContinue = [_object] call FUNC(canContinue);

if (!_canContinue) exitWith {
    [QGVAR(failed), [_object]] call CBA_fnc_globalEvent;
};

// TODO: Possible future enhancement. Consider some optional randomness.
// And possibly variant with transfer speed (function?) and amount to transfer instead of time.
private _newProgress = _progress + _progressPerTick;

// TODO: Possible future enhancement. Consider success event only when someone check progress.
if (_newProgress > MAX_PROGRESS) exitWith {
    [QGVAR(successful), [_object]] call CBA_fnc_globalEvent;
};

// TODO: Possible future enhancement. Consider action to check progress instead of notifying everyone.
// Probably also include estimated completion time then.
private _progressText = format ["%1%2", _newProgress toFixed 2, "%"];
[QGVAR(progress), [_object, _progressText]] call CBA_fnc_globalEvent;

[FUNC(loop), [_object, _progressPerTick, _newProgress], PROGRESS_INTERVAL] call CBA_fnc_waitAndExecute;
