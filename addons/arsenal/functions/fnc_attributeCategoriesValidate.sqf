#include "script_component.hpp"
/*
 * Author: veteran29
 * Validate Categories 3DEN attribute
 *
 * Arguments:
 * 0: Categories checkboxes <CONTROL>
 * 1: Checkbox index <NUMBER>
 * 2: Checkbox value <BOOL>
 *
 * Return Value:
 * Validation succeded <BOOL>
 *
 * Public: No
 */

params ["_ctrlCategories", "_selectedIndex", "_currentState"];

// no need to run validation if category is being enabled
if (_currentState > 0) exitWith {
    true // return
};

private _value = [];
{
    _value pushBack (_ctrlCategories ctrlChecked _forEachIndex);
} forEach ATTRIBUTE_CATEGORIES_DEFAULT_VALUE;

if (_value find true == -1) exitWith {
    [LLSTRING(3DEN_Categories_Invalid), 1, 4] call BIS_fnc_3DENNotification;

    _ctrlCategories ctrlSetChecked [_selectedIndex, true];

    false // return
};

true // return
