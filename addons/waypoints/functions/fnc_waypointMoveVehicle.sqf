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

[_group] call FUNC(seperateGroupVehicles);

private _vehicle = vehicle leader _group;

// creating move waypoint when leader is not in vehicle
if (vehicle leader _group == leader _group) exitWith {
    _group addWaypoint [_pos, 0, (currentWaypoint _group) + 1];
    true;
};

//update pos used in WUAE
_vehicle setVariable [QGVAR(targetMovePosition), _pos];

//create WUAE only when needed
if !(_vehicle getVariable [QGVAR(ActiveVehicleMove), false]) then {
        _vehicle setVariable [QGVAR(ActiveVehicleMove), true];
    //WUAE
    [{
            //condition
            params ["_vehicle","_scriptHandle"];
            if  (scriptDone _scriptHandle) exitWith {true};
            if !(alive (driver _vehicle)) exitWith {true};
            if (lifeState (driver _vehicle) == "INCAPACITATED") exitWith {true};
            if (_vehicle distance2D (_vehicle getVariable (QGVAR(targetMovePosition))) < 8) exitWith {true};

            _vehicle setDriveOnPath [getPosATL _vehicle, _vehicle getVariable QGVAR(targetMovePosition)];
            false;
            },{
            //code when true
            params ["_vehicle"];
            (group driver _vehicle) move (getPosATL _vehicle);
            _vehicle setVariable [QGVAR(ActiveVehicleMove), false];
            },[_vehicle,_thisScript]
    ] call CBA_fnc_waitUntilAndExecute;
};

waitUntil {sleep 0.2; !(_vehicle getVariable [QGVAR(ActiveVehicleMove),false])}
