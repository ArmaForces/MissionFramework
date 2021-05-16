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
 * Public: No
 */

params ["_ctrlGrp", "_value"];

TRACE_2("Load",_ctrlGrp,_value);

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_SUPPLYCLASSES_LIST;
private _items = parseSimpleArray _value;

[_ctrlList, _items] call FUNC(attributeSupplyClassesListAdd);

nil
