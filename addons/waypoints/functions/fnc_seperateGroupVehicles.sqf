#include "script_component.hpp"
/*
 * Author: Command DDOS
 *
 * Arguments:
 * 0: group
 * 1: clone waypoint from original group <BOOLEAN, defaults to true>
 * 2: random pos near cloned waypoint <NUMBER, defaults to 3>
 *
 * Return Value:
 * Array of new groups <ARRAY>
 *
*/

params [
    ["_group", grpNull, [grpNull]],
    ["_cloneWaypoint", true, [true]],
    ["_waypointRandomDif", 3, [0]]
];

private _vehicles = [];

{
    _vehicles pushBackUnique (vehicle _x);
} forEach (units _group);

_vehicles = (_vehicles - [vehicle leader _group]) select {assignedDriver _x in (units _group)};
if (count _vehicles == 0) exitWith {[]};

private _newgroups = [];

{
    private _vehicle = _X;
    private _oldGroup = group driver _vehicle;
    private _newGroup = createGroup (side _group);
    private _UnitsInVehicle = (units _group select {_x in (crew _vehicle)});
    _UnitsInVehicle joinSilent _newGroup;
    _group leaveVehicle  _vehicle;
    _newGroup addVehicle _vehicle;
    _newGroup setBehaviour (combatBehaviour _group);

    if (_cloneWaypoint) then {
        private _waypointPos = (getWPPos [_oldGroup,currentWaypoint _oldGroup]);
        if (_waypointPos isEqualTo [0,0,0]) exitwith {};
        private _waypointType = waypointType [_oldGroup,currentWaypoint _oldGroup];
        private _waypointScript = waypointScript [_oldGroup,currentWaypoint _oldGroup];
        private _nearPos = _waypointPos vectorAdd [random _waypointRandomDif,random _waypointRandomDif,0];
        private _waypoint = _newGroup addWaypoint [_nearPos,0];
        _newGroups = _newGroups + [_newGroup];
        _waypoint setWaypointType _waypointType;
        if !(_waypointScript == "") then {
             _waypoint setWaypointScript _waypointScript;
             };
        };
} forEach _vehicles;

_newGroups