#include "script_component.hpp"
/*
 * Author: Command DDOS
 * Used in waypoint, create new groups with waypoint from original group
 *
 * Arguments:
 * 0: Array Of vehicles
 *
 * Return Value:
 * none
 *
*/

params ["_vehicles"];

{
    private _vehicle = _X;
    private _oldGroup = group driver _vehicle;
    private _pos = (getWPPos [_oldGroup,currentWaypoint _oldGroup]);
    private _waypointType = waypointType [_oldGroup,currentWaypoint _oldGroup];
    private _waypointScript = waypointScript [_oldGroup,currentWaypoint _oldGroup];
    private _newgroup = createGroup (side _group);
    private _UnitsInVehicle = (units _group select {_x in (crew _vehicle)});
    _UnitsInVehicle joinSilent _newGroup;
    _group leaveVehicle  _vehicle;
    _newgroup addVehicle _vehicle;
    private _nearPos = _pos vectorAdd [random 5,random 5,0];
    private _waypoint = _newGroup addWaypoint [_nearPos,0];
    _waypoint setWaypointType _waypointType;
    if !(_waypointScript == "") then {
         _waypoint setWaypointScript _waypointScript;
         };
} forEach _vehicles