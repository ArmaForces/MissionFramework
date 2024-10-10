#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afmf_main"
        };
        author = "ArmaForces";
        authors[] = {"Command DDOS"};
        VERSION_CONFIG;
    };
};

#include "CfgWaypoints.cfg"
#include "ZEN_CfgWaypointTypes.hpp"
#include "CfgEventHandlers.hpp"
