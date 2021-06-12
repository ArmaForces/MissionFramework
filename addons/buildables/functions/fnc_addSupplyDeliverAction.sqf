#include "script_component.hpp"
/*
 * Author: veteran29
 * Add delivery/build action on supply items.
 *
 * Arguments:
 * 0: Classname of the supply object <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

params [
    ["_class", "", [""]]
];

if (_class == "" || {_class in GVAR(intializedClasses)}) exitWith {};
GVAR(intializedClasses) pushBack _class;

private _insertChildren = {
    params ["_target"];

    private _actions = [];
    {
        private _area = _y;
        private _action = [
            format [QGVAR(deliver_%1), _area get "layer"],
            format ["%1 (%2/%3)", _area get "displayName", _area get "currentSupplies", _area get "requiredSupplies"],
            "\a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa",
            {
                (_this select 2) params ["_area"];

                [QGVAR(deliverSupply), [AREA_ID(_area), _target, _player]] call CBA_fnc_globalEvent;
            },
            {
                (_this select 2) params ["_area"];

                !(_area get "built")
                && {_target inArea (_area get "area")}
            },
            {},
            [_area]
        ] call ace_interact_menu_fnc_createAction;

        _actions pushBack [_action, [], _target];
    } forEach GVAR(areas);

    _actions // return
};

private _rootAction = [
    QGVAR(build),
    LLSTRING(Action_Deliver),
    "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa",
    {},
    {true},
    _insertChildren
] call ace_interact_menu_fnc_createAction;

[_class, 0, ["ACE_MainActions"], _rootAction] call ace_interact_menu_fnc_addActionToClass;

nil
