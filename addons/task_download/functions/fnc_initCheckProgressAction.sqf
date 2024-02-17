#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes download action on given object.
 * Runs clientside.
 *
 * Arguments:
 * 0: Object to assign an action to <OBJECT>
 * 1: Actual action code <FUNC>
 * 2: Condition for showing action <FUNC>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_object"];

if (!hasInterface) exitWith {};

private _statement = {
    params ["_object"];
    [QGVAR(checkProgress), [_object, player]] call CBA_fnc_serverEvent;
};

private _showCondition = {
    params ["_object"];
    _object getVariable [QGVAR(downloadStarted), false]
};

private _action = [
    QGVAR(checkProgressAction),
    LLSTRING(CheckProgressAction),
    "",
    _statement,
    _showCondition,
    {}, [_object], "", 4, [false, false, false, false, false], {}
] call ACEFUNC(interact_menu,createAction);

private _actionPath = [
    _object,
    ACTION_TYPE,
    ["ACE_MainActions"],
    _action
] call ACEFUNC(interact_menu,addActionToObject);

_object setVariable [QGVAR(checkProgressActionPath), _actionPath];

nil
