#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Removes download action from object.
 *
 * Arguments:
 * 0: Object which is used for the download <OBJECT>
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

private _actionPath = _object getVariable [QGVAR(downloadActionPath), []];

if (_actionPath isEqualTo []) exitWith {
    WARNING_1("Could not remove action from object %1",_object)
};

[_object, ACTION_TYPE, _actionPath] call ACEFUNC(interact_menu,removeActionFromObject);

nil
