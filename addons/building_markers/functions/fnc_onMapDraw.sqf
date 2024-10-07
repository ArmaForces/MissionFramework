#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlMap] call afmf_building_markers_fnc_onMapDraw
 *
 * Public: No
 */

// magic number
#define ZOOM_PTS_BASE 800
#define PTS_OBJ 9
#define ADDON_MARKERS (allMapMarkers select {_x find QGVAR(icon) == 0})

params ["_ctrlMap"];
if (!GVAR(enabled)) exitWith {};

private _scaleInv = 1 / ctrlMapScale _ctrlMap;
private _zoomPts = ZOOM_PTS_BASE * (_scaleInv) * GVAR(landSizeInv);

if (GVAR(visibleObj) && (_zoomPts < PTS_OBJ)) exitWith {
    TRACE_1("hiding",_zoomPts);

    GVAR(visibleObj) = false;
    {_x setMarkerAlphaLocal 0} forEach ADDON_MARKERS;
};

if (!GVAR(visibleObj) && (_zoomPts > PTS_OBJ)) exitWith {
    TRACE_1("showing",_zoomPts);

    GVAR(visibleObj) = true;
    {_x setMarkerAlphaLocal 1} forEach ADDON_MARKERS;
};
