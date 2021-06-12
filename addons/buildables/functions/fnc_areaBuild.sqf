#include "script_component.hpp"
/*
 * Author: veteran29
 * Build area objects.
 *
 * Arguments:
 * 0: Area hash <HASHMAP>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [
    ["_area", createHashMap]
];

private _objects = getMissionLayerEntities (_area get "layer") select 0;
private _buildTime = _area get "buildTime";

if (_buildTime < 1) exitWith {
    {_x hideObjectGlobal false} forEach _objects;

    [QGVAR(built), _area get "layer"] call CBA_fnc_globalEvent;
};

private _delay = _buildTime / count _objects;

private _fnc_build = {
    params ["_fnc_build", "_delay", "_objects", "_area"];
    ([_objects deleteAt 0] param [0, objNull]) hideObjectGlobal false;
    
    if (_objects isEqualTo []) exitWith {
        [QGVAR(built), _area get "layer"] call CBA_fnc_globalEvent;
    };

    [_fnc_build, _this, _delay] call CBA_fnc_waitAndExecute;
};

[_fnc_build, _delay, _objects, _area] call _fnc_build;
