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

params ["_object", "_statement", "_showCondition"];

if (isServer) exitWith {};

private _action = [
    QGVAR(startDownloadAction),
    LLSTRING(StartAction),
    "",
    _statement,
    _showCondition,
    {}, [_object], "", 4, [false, false, false, false, false], {}
] call ACEFUNC(interact_menu,createAction);

private _actionPath = [
    _object,
    0,
    ["ACE_MainActions"],
    _action
] call ACEFUNC(interact_menu,addActionToObject);

_object setVariable [QGVAR(actionPath), _actionPath];

nil
