#include "script_component.hpp"
/*
 * Author: veteran29
 * Saves value of Categories 3DEN attribute
 *
 * Arguments:
 * 0: Attribute group <CONTORL>
 *
 * Return Value:
 * Attribue value <STRING>
 *
 * Public: No
 */

private _ctrlCategories = (_this controlsGroupCtrl IDC_ATTRIBUTE_CATEGORIES);
private _value = [];
{
    _value pushBack (_ctrlCategories ctrlChecked _forEachIndex);
} forEach ATTRIBUTE_CATEGORIES_DEFAULT_VALUE;

TRACE_1("Saving categories attribute",_value);

str _value
