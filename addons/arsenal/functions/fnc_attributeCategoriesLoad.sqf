#include "script_component.hpp"
/*
 * Author: vetran29
 * Loads value of Categories 3DEN attribute
 *
 * Arguments:
 * 0: Attribute group <CONTROL>
 * 1: Saved attribute value <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_ctrlGrp", "_value"];

TRACE_1("Loading categories attribute",_value);

{
    (_ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_CATEGORIES) ctrlSetChecked [_forEachIndex, _x];
} forEach parseSimpleArray _value;

nil
