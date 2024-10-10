#include "script_component.hpp"
/*
 * Author: Command DDOS
 *
 * Arguments:
 * 0: group
 * 1: pos
 *
 * Return Value:
 * none
 *
*/

params ["_group", "_pos"];

if !(local _group) exitWith {false};


private _vehicles = [];
{
    _vehicles pushBackUnique (vehicle _x);
} forEach (units _group);

_vehicles = _vehicles select {assignedDriver _x in (units _group)};
if (count _vehicles == 0) exitWith {true};
private _vehicle = vehicle leader _group;

// create groups with waypoint for vehicles without leader vehicle
if !(count (_vehicles - [_vehicle]) == 0) then {
     [_vehicles - [_vehicle]] call FUNC(seperateGroupVehicles);
};

if !(driver _vehicle in (units _group)) exitWith {true};

// this should allow fast fix bugged driver behaviour by changing waypoint position by zeus
If (speed _vehicle < 4) then {
    _vehicle engineOn false;
};
// update pos used in WUAE
_vehicle setVariable [QGVAR(targetMovePosition), _pos];

// create WUAE only when needed
if !(_vehicle getVariable [QGVAR(ActiveVehicleMove), false]) then {
    _vehicle setVariable [QGVAR(ActiveVehicleMove), true];
// WUAE
[{
        // condition
        params ["_vehicle","_group"];
        if !(waypointScript [_group,currentWaypoint _group] == QPATHTOF(functions\fnc_waypointMoveVehicle.sqf)) exitWith {true};
        if !(alive (driver _vehicle)) exitWith {true};
        if (lifeState (driver _vehicle) == "INCAPACITATED") exitWith {true};
        if (_vehicle distance2D (_vehicle getVariable (QGVAR(targetMovePosition))) < 8) exitWith {true};

        _vehicle setDriveOnPath [getPosATL _vehicle, _vehicle getVariable QGVAR(targetMovePosition)];
        false;
        },{
        // code when true
        params ["_vehicle"];
        (group driver _vehicle) move (getPosATL _vehicle);
        _vehicle setVariable [QGVAR(ActiveVehicleMove), false];
        },[_vehicle,_group]
] call CBA_fnc_waitUntilAndExecute;
};

waitUntil {sleep 0.2; !(_vehicle getVariable [QGVAR(ActiveVehicleMove),false])}
