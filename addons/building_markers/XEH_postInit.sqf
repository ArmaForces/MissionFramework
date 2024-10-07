#include "script_component.hpp"

if (hasInterface) then {
    // disable editing of the building markers via ZEUS with ZEN
    zen_area_markers_blacklist pushBack QUOTE(ADDON);

    GVAR(visibleObj) = true;
    GVAR(landSizeInv) = 1 / (getTerrainInfo select 1);

    (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", LINKFUNC(onMapDraw)];
};
