#include "script_component.hpp"
/*
 * Author: Command DDOS
 *
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

if !(local _group) exitwith {false};

//vehicle list
private _vehicles = [];
{
    _vehicles pushBackUnique (vehicle _x);
} forEach (units _group);

_vehicles = _vehicles select {assignedDriver _x in (units _group)};

if (count _vehicles == 0) exitwith {true};


private _LeaderVehicle = vehicle leader _group;

// create groups with waypoint for vehicles without leader vehicle
{
    private _vehicle = _X;
    private _newgroup = createGroup (side _group);
    private _UnitsInVehicle = (units _group select {_x in (Crew _vehicle)});
    _UnitsInVehicle joinSilent _newGroup;
    _group leaveVehicle  _vehicle;
    _newgroup addVehicle _vehicle;
    private _nearPos = _pos vectorAdd [random 5,random 5,0];
    private _waypoint = _newGroup addWaypoint [_nearPos,0];
    _waypoint setWaypointType "SCRIPTED";
    _waypoint setWaypointScript QPATHTOF(functions\fnc_moveVehicleWP.sqf);
} foreach (_vehicles - [_LeaderVehicle]);

if !(driver _LeaderVehicle in (units _group)) exitwith {true};

// at this point there should be always 1 vehicle to process with leader inside
 private _driver = driver _LeaderVehicle;

    //prevent when driver is not avaible
if !(alive _driver) exitwith {true};
if (lifestate _driver == "INCAPACITATED") exitwith {true};

    //calculate positions
    private _posVehicleATL = getposATL _LeaderVehicle;
    private _vectorDir = _posVehicleATL vectorDiff _pos;
    private _vectorDirNormalized = vectorNormalized _vectorDir ;
    private _pos1 = _pos vectorAdd (_vectorDirNormalized vectorMultiply 1);
    private _pos2 = _pos;
    private _pos3 = _pos vectorAdd (_vectorDirNormalized vectorMultiply -1);
    //update pos used in WUAE
    _LeaderVehicle setvariable [QGVAR(TargetArrayMovePosition),[_pos1,_pos2,_pos3]];

   //create WUAE only when needed
if !(_LeaderVehicle getvariable [QGVAR(ActiveVehicleMove),false]) then {

        _LeaderVehicle setvariable [QGVAR(ActiveVehicleMove),true];

        //making group/unit easier to command
        _driver setVariable ["lambs_danger_disableAI", true];
        (group _driver) setVariable ["lambs_danger_disablegroupAI", true];

        _driver enableAI "PATH";
        _driver domove _pos2;
        _driver disableAI "AUTOTARGET";
        _driver disableAI "AUTOCOMBAT";
        _driver disableAI "TARGET";
        _driver disableai "COVER";
        _driver disableai "FSM";
        _driver setBehaviour "AWARE";

        _LeaderVehicle setvariable [QGVAR(DriverWaitTime),(time + 1)];
        _LeaderVehicle setDriveOnPath (_LeaderVehicle getvariable QGVAR(TargetArrayMovePosition));

        [{
        //condition
            params ["_vehicle","_group"];
            if !(waypointScript [_group,currentWaypoint _group] == QPATHTOF(functions\fnc_moveVehicleWP.sqf)) exitwith {true};
            if !(alive (driver _vehicle)) exitwith {true};
            if (lifestate (driver _vehicle) == "INCAPACITATED") exitwith {true};
            if (_vehicle distance2d (_vehicle getvariable (QGVAR(TargetArrayMovePosition)) select 1) < 8 ) exitwith {true};
            //refresh AI from "stuck" or move to updated position

            if (_vehicle getvariable QGVAR(DriverWaitTime) < time) then {
                    _vehicle setvariable [QGVAR(DriverWaitTime),(time + 2)];
                    if (speed _vehicle < 4) then {
                        (driver _vehicle) disableAI "Path";
                        (driver _vehicle) enableAI "Path";
                    };
                    if !(isFormationLeader (driver _vehicle)) then {
                        (driver _vehicle) doFollow leader (driver _vehicle);
                        dostop (driver _vehicle);
                };
                (driver _vehicle) domove ( _vehicle getvariable QGVAR(TargetArrayMovePosition) select 1);
                _vehicle setDriveOnPath ( _vehicle getvariable QGVAR(TargetArrayMovePosition));
                false;
            }
            },{
        //code when true
            params ["_vehicle"];

            //fixing driver behaviour where he can ignore all move orders if vehicle don't achive setDriveOnPath destinations before doFollow.
            private _point1 = _vehicle getrelpos [2,0];
            private _point2 = _vehicle getrelpos [3,0];
            _vehicle setDriveOnPath [_point1,_point2];

            [{
                params ["_vehicle"];
                (driver _vehicle) doFollow (leader (driver _vehicle));
                (driver _vehicle) domove (getposATL _vehicle);
                (driver _vehicle) enableAI "all";
                (driver _vehicle) setVariable ["lambs_danger_disableAI", false];
                (group (driver _vehicle)) setVariable ["lambs_danger_disablegroupAI", false];
                _vehicle setvariable [QGVAR(ActiveVehicleMove),false];
            },[_vehicle],0.2] call cba_fnc_waitAndExecute;

            },[_LeaderVehicle,_group]
    ] call CBA_fnc_waitUntilAndExecute;
};

waitUntil {sleep 0.4; !(_LeaderVehicle getvariable [QGVAR(ActiveVehicleMove),false])};

// end
true