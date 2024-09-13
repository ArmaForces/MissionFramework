#include "script_component.hpp"
/*
 * Author: veteran29
 * Fill combo box with list of editor layers.
 *
 * Arguments:
 * 0: combo box <CONTROL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_control"];

private _picture = getText (configFile >> 'Cfg3DEN' >> 'Layer' >> 'Draw' >> 'icon');
private _layerText = localize 'STR_3DEN_Layer_textSingular';
private _layers = (all3DENEntities select 6) apply {(_x get3DENAttribute 'name') select 0};

_layers sort true;

{
    _lbAdd = _control lbAdd format ['%1: %2', _layerText, _x];
    _control lbSetPicture [_lbAdd, _picture];

    _control lbSetData [_lbAdd, _x];
} forEach _layers;

nil
