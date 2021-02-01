#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    [QGVAR(switchLight), LINKFUNC(switchLight)] call CBA_fnc_addEventHandler;
};

[QGVAR(switchLightLocal), {
    params ["_object", "_state"];

    _object switchLight _state;
}] call CBA_fnc_addEventHandler;

ADDON = true;
