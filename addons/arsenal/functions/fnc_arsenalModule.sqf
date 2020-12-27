#include "script_component.hpp"
/*
 * Author: veteran29
 * Initialization function of Unit Arsenal module.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

[{
    params [
        ["_logic", objNull, [objNull]]
    ];

    private _deleteUnits = _logic getVariable [QGVAR(deleteUnits), false];

    private _syncedUnits = synchronizedObjects _logic select {_x isKindOf "CAManBase"};
    private _syncedObjects = synchronizedObjects _logic - _syncedUnits;

    TRACE_3("Initializing arsenal module",_syncedUnits,_syncedObjects,_deleteUnits);

    private _gear = [];
    {

    } forEach _syncedUnits;
}, _this] call CBA_fnc_directCall;

nil
