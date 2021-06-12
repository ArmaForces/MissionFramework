#include "script_component.hpp"
/*
 * Author: veteran29
 * Inits buildable area.
 *
 * Arguments:
 * 0: Editor layer name <STRING>
 * 1: Supplies delivery area, marker name or area array <STRING, ARRAY>
 * 2: Area display name <STRING>
 * 3: Amount of required supplies <NUMBER, defaults to 1>
 * 4: How long it takes to build the area <NUMBER, defaults to 60>
 * 5: Should layer objects be hidden <BOOL, defaults to false>
 * 6: Class names of objects that can be used to supply the area <BOOL, defaults to false>
 *
 * Return Value:
 * Area was initialized <BOOL>
 *
 * Example:
 * ["checkpoint_1", "checkpoint_1_area"] call afmf_buildables_fnc_areaInit
 *
 * Public: Yes
 */

if (!isServer) exitWith {false};

params [
    ["_layer", "", [""]],
    ["_deliveryArea", "", ["", []]],
    ["_displayName", "", [""]],
    ["_requiredSupplies", 1, [0]],
    ["_buildTime", 60, [0]],
    ["_hideObjects", false, [true]],
    ["_supplyCrates", ["B_supplyCrate_F"], [[]]]
];

TRACE_7("Initializing buildable area",_layer,_area,_displayName,_requiredSupplies,_buildTime,_hideObjects,_supplyCrates);

private _objects = (getMissionLayerEntities _layer) select 0;
if (_objects isEqualTo []) exitWith {
    ["Provided layer does not contain any objects! - %1", _layer] call BIS_fnc_error;
    false
};

if (_displayName == "") then {
    _displayName = _layer;
};

if (_hideObjects) then {
    {_x hideObjectGlobal true} forEach _objects;
};

private _areaHash = createHashMapFromArray [
    ["layer", _layer],
    ["area", _deliveryArea],
    ["displayName", _displayName],
    ["requiredSupplies", _requiredSupplies max 1],
    ["currentSupplies", 0],
    ["buildTime", _buildTime max 0],
    ["supplyCrates", _supplyCrates],
    ["built", false]
];

private _jipId = [QGVAR(registerArea), _areaHash] call CBA_fnc_globalEventJIP;
_areaHash set ["jipId", _jipId];

true
