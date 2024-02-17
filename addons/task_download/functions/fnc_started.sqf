#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Removes download action from object.
 *
 * Arguments:
 * 0:
 *
 * Return Value:
 *
 *
 * Example:
 *
 *
 * Public: No
 */

params ["_object"];

private _actionPath = _object getVariable [QGVAR(actionPath), []];

if (_actionPath isEqualTo []) exitWith {
    WARNING_1("Could not remove action from object %1",_object)
};

[_object, ACTION_TYPE, _actionPath] call ACEFUNC(interact_menu,removeActionFromObject);
