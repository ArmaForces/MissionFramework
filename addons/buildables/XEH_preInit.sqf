#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(areas) = createHashMap;

[QGVAR(registerArea), {
    TRACE_1("Registering area",_this);

    GVAR(areas) set [_this get AREA_ID_KEY, _this];

    {
        _x call FUNC(addSupplyDeliverAction);
    } forEach (_this get "supplyCrates");
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    GVAR(intializedClasses) = [];

    [QGVAR(deliverNotify), {
        params ["_built"];

        if (_built) exitWith {
            "Built" call CBA_fnc_notify;
            playSound "defaultNotification";
        };

        "Delivered" call CBA_fnc_notify;
        playSound "defaultNotificationClose";
    }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    [QGVAR(deliverSupply), {
        params ["_areaId", ["_supply", objNull], ["_supplier", [objNull]]];

        private _area = GVAR(areas) get _areaId;

        INFO_3("Supply delivered to area - %1, %2, %3",_area get "displayName",_areaId,_supply);

        private _required = _area get "requiredSupplies";
        private _current = _area get "currentSupplies";
        _current = _current + 1;

        _area set ["currentSupplies", _current];

        deleteVehicle _supply;

        // update area status on all clients/jip
        [QGVAR(registerArea), _area, _area get "jipId"] call CBA_fnc_globalEventJIP;

        if (_current >= _required) then {
            [QGVAR(buildArea), [AREA_ID(_area)]] call CBA_fnc_serverEvent;
        };

        [QGVAR(delivered), _area get "layer"] call CBA_fnc_globalEvent;
        [QGVAR(deliverNotify), [_current >= _required], _supplier] call CBA_fnc_targetEvent;

    }] call CBA_fnc_addEventHandler;

    [QGVAR(buildArea), {
        params ["_areaId"];

        private _area = GVAR(areas) get _areaId;

        INFO_2("Building area - %1, %2",_area get "displayName",_area get "area");

        _area set ["built", true];

        // update area status on all clients/jip
        [QGVAR(registerArea), _area, _area get "jipId"] call CBA_fnc_globalEventJIP;

        _area call FUNC(areaBuild);
    }] call CBA_fnc_addEventHandler;
};

ADDON = true;
