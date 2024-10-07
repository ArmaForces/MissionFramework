#include "script_component.hpp"
/*
 * Author: veteran29
 * Creates building markers for objects synchronized to the module.
 *
 * Arguments:
 * 0: Module <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith {};

params ["_module"];

private _objects = synchronizedObjects _module;
_objects = _objects select {(_x namedProperties ["Geometry"]) getOrDefault ["map", ""] != ""};

TRACE_2("Creating markers",_module,count _objects);

[_objects] call FUNC(create);
