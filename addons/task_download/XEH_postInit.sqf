#include "script_component.hpp"

if (isServer) then {
    [QGVAR(start), FUNC(start)] call CBA_fnc_addEventHandler;

    [QGVAR(pendriveUnplugged), {
        params ["_object"];

        _object setVariable [QGVAR(pendriveUnplugged), true, true];
        [QGVAR(successful), [_object]] call CBA_fnc_globalEvent;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(successful), {
        ["ocap_customEvent", ["generalEvent", "Intel was downloaded!"]] call CBA_fnc_serverEvent;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(failed), {
        systemChat LLSTRING(Failed);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(started), FUNC(started)] call CBA_fnc_addEventHandler;

    [QGVAR(startFailed), {
        params ["_msg"];
        systemChat (_msg call BIS_fnc_localize);
    }] call CBA_fnc_addEventHandler;
};
