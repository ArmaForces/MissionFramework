#include "script_component.hpp"
/*
 * Author: veteran29
 * Fill the classes tree with supply item classes.
 *
 * Arguments:
 * 0: Tree view <CONTROL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_tv"];

private _classes = "
    getNumber (_x >> 'scope') == 2
    && {configName _x isKindOf 'ThingX'}
" configClasses (configFile >> "CfgVehicles");

{
    _idx = _tv tvAdd [[], getText (_x >> "displayName")];
    _tv tvSetData [[_idx], configName _x];
} forEach _classes;

_tv tvSort [[], false];

nil
