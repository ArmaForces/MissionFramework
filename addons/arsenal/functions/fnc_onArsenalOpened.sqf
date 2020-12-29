#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle arsenal open
 *
 * Arguments:
 * 0: Arsenal display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afmf_arsenal_fnc_onArsenalOpened
 *
 * Public: No
 */

params ["_display"];

private _enabledCategories = GVAR(currentBox) getVariable QGVAR(enabledCategories);
if (isNil "_enabledCategories") exitWith {};

private _categoriesIdcs = ARSENAL_CATEGORIES_IDCS;

TRACE_2("Handling arsenal open",count _enabledCategories,count _categoriesIdcs);

// disable arsenal categories
private _firstEnabledIDC = -1;
{
    private _enabled = _enabledCategories select _forEachIndex;
    if (!_enabled) then {
        TRACE_1("Disabling category",_x);
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlEnable false;
        _ctrl ctrlSetFade 0.6;
        _ctrl ctrlCommit 0;
    } else {
        if (_firstEnabledIDC == -1) then {
            _firstEnabledIDC = _x;
        };
    };
} forEach _categoriesIdcs;

// focus first enabled category
[{
    params ["_display", "_idc"];
    [_display, _display displayCtrl _idc] call ace_arsenal_fnc_fillLeftPanel;
}, [_display, _firstEnabledIDC]] call CBA_fnc_execNextFrame;

nil
