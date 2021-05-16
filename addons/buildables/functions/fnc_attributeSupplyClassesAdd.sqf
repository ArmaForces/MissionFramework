#include "script_component.hpp"
/*
 * Author: veteran29
 * Add selected class (left panel) to list of supply classes (right panel).
 *
 * Arguments:
 * 0: Add button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ['_btn'];

private _ctrlGrp = ctrlParentControlsGroup _btn;

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_SUPPLYCLASSES_LIST;
private _ctrlTv = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_SUPPLYCLASSES_CLASSES;

private _selectedClass = _ctrlTv tvData tvCurSel _ctrlTv;

[_ctrlList, [_selectedClass]] call FUNC(attributeSupplyClassesListAdd);

nil
