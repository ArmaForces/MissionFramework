#include "script_component.hpp"
/*
 * Author: Ampersand, veteran29
 * Creates the given object's building marker.
 *
 * Building markers are grey rectangle area markers for the object's bounding box
 * that mimic those of terrain buildings.
 *
 * When called in create mode for an object that already has a building marker,
 * the object's marker is updated to reflect its current position and direction.
 *
 * The marker is automatically updated if the object is edited by Zeus and
 * deleted when the object is deleted. However, the marker will not update if the
 * object is edited by some other means (e.g., through script).
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call afmf_building_markers_fnc_create
 *
 * Public: Yes
 */

if (!isServer) exitWith {
    [QGVAR(create), _this] call CBA_fnc_serverEvent;
};

params [
    ["_object", objNull, [objNull, []]]
];

TRACE_1("Create",_object);

if (_object isEqualType []) exitWith {
    {
        [_x] call FUNC(create);
    } forEach _object;
};

if (isNull _object) exitWith {};

private _marker = _object getVariable [QGVAR(marker), ""];

// Only update marker if it already exists
if (_marker != "") exitWith {
    _marker setMarkerPosLocal getPos _object;
    _marker setMarkerDir getDir _object;
};

// Create marker for the given object
0 boundingBoxReal _object params ["_p0", "_p1"];
private _size = _p1 vectorDiff _p0 vectorMultiply 0.5 select [0, 2];

_marker = createMarker [format [QGVAR(%1), _object call BIS_fnc_netId], _object];

switch ((_x namedProperties ["Geometry"]) getOrDefault ["map", ""]) do {
    default {
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerColorLocal "ColorGrey";
        _marker setMarkerBrushLocal "SolidFull";
        _marker setMarkerSizeLocal _size;
        _marker setMarkerDir getDir _object;
    };
};

_object setVariable [QGVAR(marker), _marker, true];

// Delete marker when the object is deleted
private _eventID = _object addEventHandler ["Deleted", {
    params ["_object"];

    deleteMarker (_object getVariable [QGVAR(marker), ""]);
}];

_object setVariable [QGVAR(eventID), _eventID];
