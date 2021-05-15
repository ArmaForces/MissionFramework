#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afmf_main_fnc_example
 *
 * Public: No
 */

params ["_ctrlGrp"];

TRACE_1("Save",_ctrlGrp);

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_TWOPANEL_LIST;

private _items = [];
for "_i" from 0 to lbSize _ctrlList do {
    _items pushBack (_ctrlList lbData _i);
};

str _items // return
