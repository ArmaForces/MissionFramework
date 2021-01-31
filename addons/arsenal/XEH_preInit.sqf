#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[QGVAR(addArsenal), {
    [{
        !isNull player
        && {time > 1}
        && {
            !IS_MOD_LOADED(acre_main)
            || {!isNil "acre_api_fnc_isInitialized" && {[] call acre_api_fnc_isInitialized}}
        }
    }, {
        params ["_object", "_items", "_addPlayerItems", "_categories"];

        TRACE_3("Adding local arsenal to object",_object,_addPlayerItems,_categories);
        TRACE_1("",_items);

        if (_addPlayerItems) then {
            _items append (player call FUNC(getUnitGear));
        };

        _object setVariable [QGVAR(enabledCategories), _categories];

        [_object] call FUNC(initBox);
        [_object, _items] call ACEFUNC(arsenal,addVirtualItems);
    }, _this] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

[QACEGVAR(arsenal,displayOpened), {
    // delay is needed, otherwise disabling of some categories does not work.
    [LINKFUNC(onArsenalOpened), _this] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

ADDON = true;
