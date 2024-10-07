#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    [QGVAR(create), LINKFUNC(create)] call CBA_fnc_addEventHandler;
    [QGVAR(delete), LINKFUNC(create)] call CBA_fnc_addEventHandler;
};

GVAR(enabled) = false;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectEdited", {call FUNC(handleObjectEdited)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
