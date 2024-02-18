#include "script_component.hpp"
/*
 * Author: Mike, Jonpas from Theseus Mods
 * Returns randomized date time, without a year.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Random date time <ARRAY>
 *  0: Weekday <STRING>
 *  1: Month <STRING>
 *  2: Day <NUMBER>
 *  3: Hours <NUMBER>
 *  4: Minutes <NUMBER>
 *  5: Seconds <NUMBER>
 *
 * Example:
 * call afmf_task_download_fnc_randomDateTime
 *
 * Public: No
 */

#define WEEKDAYS ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
#define MONTHS ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

private _date = date;
private _dateNumber = dateToNumber _date;
_dateNumber = _dateNumber - ((1 / 365 / 24) * random 23);
_date = numberToDate [_date select 0, _dateNumber];

_date params ["_year", "_month", "_day", "_hours", "_minutes"];
_hours = [_hours, 2] call CBA_fnc_formatNumber;
_minutes = [_minutes, 2] call CBA_fnc_formatNumber;

private _seconds = [floor random 59, 2] call CBA_fnc_formatNumber;
private _weekDay = WEEKDAYS select ([_date] call CBA_fnc_weekDay);
private _month = MONTHS select (_month - 1);

[_weekDay, _month, _day, _hours, _minutes, _seconds]
