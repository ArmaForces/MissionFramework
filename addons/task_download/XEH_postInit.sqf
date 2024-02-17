#include "script_component.hpp"

if (isServer) then {
    [QGVAR(start), FUNC(start)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(progress), {
        params ["_object", "_progress"];
        systemChat format [LLSTRING(StatusReport), _progress];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(failed), {
        systemChat LLSTRING(Failed);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(successful), {
        systemChat LLSTRING(Finished);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(started), FUNC(started)] call CBA_fnc_addEventHandler;

    [QGVAR(startSuccessful), {
        params ["_estimatedTimeLeft"];
        systemChat format [LLSTRING(Started), _estimatedTimeLeft];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(startFailed), {
        params ["_msg"];
        systemChat (_msg call BIS_fnc_localize);
    }] call CBA_fnc_addEventHandler;
};
