#include "script_component.hpp"
/*
 * Author: veteran29
 * Add classes to list of the supply classes.
 *
 * Arguments:
 * 0: List <CONTROL>
 * 1: Array of classes <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_ctrlList", ["_classes", []]];

private _items = _ctrlList getVariable [QGVAR(items), []];
_items append _classes;
_items = _items arrayIntersect _items;
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
