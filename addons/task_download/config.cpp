#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afmf_main",
            "ace_interact_menu"
        };
        skipWhenMissingDependencies = 1;
        author = "ArmaForces";
        authors[] = {"3Mydlo3"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
