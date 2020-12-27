#include "script_component.hpp"
/*
 * Author: veteran29
 * Get unit gear in flat array, compatible with ACE Arsenal.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit items as flat array <ARRAY>
 *
 * Example:
 * [bob] call afmf_arsenal_fnc_getUnitGear
 *
 * Public: Yes
 */

params [
    ["_unit", objNull, [objNull]]
];

private _items = (weapons _unit apply {_x call BIS_fnc_baseWeapon}) + magazines _unit
    +
    [headgear _unit] + [goggles _unit]
    +
    assignedItems _unit
    +
    backpackItems _unit + [backpack _unit]
    +
    uniformItems _unit + [uniform _unit]
    +
    vestItems _unit + [vest _unit]
    +
    primaryWeaponItems _unit + secondaryWeaponItems _unit + handgunItems _unit
;

_items arrayIntersect _items // return
