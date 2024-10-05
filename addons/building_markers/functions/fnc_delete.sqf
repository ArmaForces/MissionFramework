#include "script_component.hpp"
/*
 * Author: Ampersand, veteran29
 * Deletes the given object's building marker.
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call afmf_building_markers_fnc_delete
 *
 * Public: Yes
 */

if (!isServer) exitWith {
    [QGVAR(set), _this] call CBA_fnc_serverEvent;
};

params [
    ["_object", objNull, [objNull, []]]
];

TRACE_1("Delete",_object);

if (_object isEqualType []) exitWith {
    {
        [_x] call FUNC(delete);
    } forEach _object;
};

if (isNull _object) exitWith {};

private _marker = _object getVariable [QGVAR(marker), ""];

if (_marker == "") exitWith {};

private _eventID = _object getVariable [QGVAR(eventID), -1];
_object removeEventHandler ["Deleted", _eventID];
_object setVariable [QGVAR(marker), nil, true];
deleteMarker _marker;
