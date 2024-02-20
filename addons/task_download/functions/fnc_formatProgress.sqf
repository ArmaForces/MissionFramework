#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Formats progress number to a string with fixed decimals and % sign.
 *
 * Arguments:
 * 0: Number to format <NUMBER>
 *
 * Return Value:
 * Number converted for display to percentage with 2 decimal places <STRING>
 *
 * Example:
 * [99.999] call afmf_task_download_fnc_formatProgress;
 * // Returns "99.99%"
 *
 * Public: No
 */

params ["_progress"];

format ["%1%2", floor(_progress * 100)/100 toFixed 2, "%"]
