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

    TRACE_1("Initializing arsenal module",_logic);

    private _deleteUnits = _logic getVariable [QGVAR(deleteUnits), true];
    private _playerItems = _logic getVariable [QGVAR(playerItems), true];
    private _allGoggles = _logic getVariable [QGVAR(allGoggles), true];
    private _categories = _logic getVariable [QGVAR(categories), ATTRIBUTE_CATEGORIES_DEFAULT_VALUE];
    TRACE_4("Module attributes",_deleteUnits,_playerItems,_allGoggles,_categories);

    private _syncedObjects = synchronizedObjects _logic;
    private _syncedUnits = _syncedObjects select {_x isKindOf "CAManBase"};
    private _syncedTriggers = _syncedObjects select {_x isKindOf "EmptyDetector"};
    private _syncedArsenals = _syncedObjects - _syncedUnits - _syncedTriggers;
    TRACE_3("Module synced",_syncedUnits,_syncedTriggers,_syncedArsenals);

    if (_syncedUnits isEqualTo [] && {!_playerItems}) then {
        ERROR_MSG("Arsenal module has no synchronized units!");
    };
    if (_syncedArsenals isEqualTo []) exitWith {
        ERROR_MSG("Arsenal module has no synchronized arsenal objects!");
        nil
    };

    private _gear = [];
    {
        _gear append (_x call FUNC(getUnitGear));

        if (_deleteUnits) then {deleteVehicle _x};
    } forEach _syncedUnits;

    if (_allGoggles) then {
        _gear append (("getNumber (_x >> 'scope') > 0" configClasses (configfile >> "CfgGlasses")) apply {configName _x});
    };

    // remove duplicates
    _gear = _gear arrayIntersect _gear;

    // wait for all synced triggers to be activated
    [{(_this select 0) findIf {!triggerActivated _x} == -1}, {
        params ["", "_syncedArsenals", "_gear", "_playerItems", "_categories"];

        {
            TRACE_3("Adding arsenal to object",_x,_playerItems,_categories);
            TRACE_1("",_gear);

            private _id = [QGVAR(addArsenal), [_x, _gear, _playerItems, _categories]] call CBA_fnc_globalEventJIP;
            // remove event after arsenal object will be deleted
            [_id, _x] call CBA_fnc_removeGlobalEventJIP;
        } forEach _syncedArsenals;
    }, [_syncedTriggers, _syncedArsenals, _gear, _playerItems, _categories]] call CBA_fnc_waitUntilAndExecute;

}, _this] call CBA_fnc_directCall;

nil
