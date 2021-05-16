#include "script_component.hpp"
/*
 * Author: veteran29
 * Remove selected item from supply classes list (right panel).
 *
 * Arguments:
 * 0: Remove button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ['_btn'];

private _ctrlGrp = ctrlParentControlsGroup _btn;

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_SUPPLYCLASSES_LIST;

private _selectedClass = _ctrlList lbData lbCurSel _ctrlList;

private _items = _ctrlList getVariable [QGVAR(items), []];
_items = _items - [_selectedClass];
_ctrlList setVariable [QGVAR(items), _items];

lbClear _ctrlList;
private _cfgVehicles = configFile >> "CfgVehicles";
{
    private _item = _x;
    if (isClass (_cfgVehicles >> _item)) then {
        private _idx = _ctrlList lbAdd getText (_cfgVehicles >> _item >> "displayName");
        _ctrlList lbSetData [_idx, _item];
    } else {
        private _idx = _ctrlList lbAdd _item;
        _ctrlList lbSetData [_idx, _item];
    };
} forEach _items;

lbSort _ctrlList;

nil
