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

private _ctrlList = _ctrlGrp controlsGroupCtrl IDC_ATTRIBUTE_TWOPANEL_LIST;

private _cfgVehicles = configFile >> "CfgVehicles";
{
    if (isClass (_cfgVehicles >> _x)) then {
        private _idx = _ctrlList lbAdd getText (_cfgVehicles >> _x >> "displayName");
        _ctrlList lbSetData [_idx, _x];
    } else {
        private _idx = _ctrlList lbAdd _x;
        _ctrlList lbSetData [_idx, _x];
    };
} forEach parseSimpleArray _value;

nil
