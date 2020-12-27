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

if (!IS_MOD_LOADED(ace_arsenal)) exitWith {
    ERROR("Can not add arsenal, ace_arsenal is not loaded");
};

[{
    params [
        ["_logic", objNull, [objNull]]
    ];

    private _deleteUnits = _logic getVariable [QGVAR(deleteUnits), true];
    private _playerItems = _logic getVariable [QGVAR(playerItems), true];

    private _syncedUnits = synchronizedObjects _logic select {_x isKindOf "CAManBase"};
    private _syncedObjects = synchronizedObjects _logic - _syncedUnits;

    TRACE_3("Initializing arsenal module",_syncedUnits,_syncedObjects,_deleteUnits);

    private _gear = [];
    {
        _gear append (_x call FUNC(getUnitGear));

        if (_deleteUnits) then {deleteVehicle _x};
    } forEach _syncedUnits;

    // remove duplicates
    _gear = _gear arrayIntersect _gear;

    {
        TRACE_3("Adding arsenal to object",_x,_gear,_playerItems);

        private _id = [QGVAR(addArsenal), [_x, _gear, _playerItems]] call CBA_fnc_globalEventJIP;
        // remove event after arsenal object will be deleted
        [_id, _x] call CBA_fnc_removeGlobalEventJIP;
    } forEach _syncedObjects;

}, _this] call CBA_fnc_directCall;

nil
