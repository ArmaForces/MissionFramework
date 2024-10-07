#include "script_component.hpp"

if (hasInterface) then {
    // disable editing of the building markers via ZEUS with ZEN
    zen_area_markers_blacklist pushBack QUOTE(ADDON);

    GVAR(visibleObj) = true;
    GVAR(landSizeInv) = 1 / (getTerrainInfo select 1);
};
