#include "script_component.hpp"
/*
 * Author: veteran29
 * Serialize selected classes for Eden attribute save.
 *
 * Arguments:
 * 0: Eden attribute control group <CONTROL>
 *
 * Return Value:
 * Stringified array of selected classes <STRING>
 *
 * Public: No
 */

params ["_ctrlGrp"];

TRACE_1("Save",_ctrlGrp);

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_SUPPLYCLASSES_LIST;

private _items = [];
for "_i" from 0 to lbSize _ctrlList - 1 do {
    _items pushBack (_ctrlList lbData _i);
};

str _items // return
