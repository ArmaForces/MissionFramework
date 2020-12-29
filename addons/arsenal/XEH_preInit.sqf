#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[QGVAR(addArsenal), {
    [{!isNull player && {time > 5}}, {
        params ["_object", "_items", "_addPlayerItems"];

        TRACE_3("Adding local arsenal to object",_object,_items,_addPlayerItems);

        if (_addPlayerItems) then {
            _items append (player call FUNC(getUnitGear));
        };

        [_object] call FUNC(initBox);
        [_object, _items] call ACEFUNC(arsenal,addVirtualItems);
    }, _this] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

ADDON = true;
