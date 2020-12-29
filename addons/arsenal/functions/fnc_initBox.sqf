#include "script_component.hpp"
/*
 * Author: Alganthe, veteran29
 * Initialize a box / object for local arsenal.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Action was added <BOOL>
 *
 * Example:
 * [_box] call afmf_arsenal_fnc_initBox
 *
 * Public: Yes
*/

params [
    ["_object", objNull, [objNull]]
];

if (isNull _object) exitWith {};

private _objectActions = _object getVariable [QACEGVAR(interact_menu,actions), []];
if (_objectActions findIf {(_x select 0) select 0 isEqualTo QGVAR(interaction)} != -1) exitWith {false};

private _action = [
    QGVAR(interaction),
    localize "STR_A3_Arsenal",
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceArsenal_ca.paa",
    {
        params ["_target", "_player"];
        GVAR(currentBox) = _target;
        [_target, _player] call ACEFUNC(arsenal,openBox);
    },
    {
        params ["_target", "_player"];
        [_player, _target] call ACEFUNC(common,canInteractWith)
    },
    {},
    []
] call ACEFUNC(interact_menu,createAction);
[_object, 0, ["ACE_MainActions"], _action] call ACEFUNC(interact_menu,addActionToObject);

true
