#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if download from given object can continue.
 *
 * Arguments:
 * 0: Object which is used for download <OBJECT>
 *
 * Return Value:
 * True if download can continue <BOOL>
 *
 * Example:
 * [laptop] call afmf_task_download_fnc_canContinue
 *
 * Public: No
 */

params ["_object"];

if (isNil "_object") exitWith { false };
if (isNull _object) exitWith { false };
if (!alive _object) exitWith { false };

true
