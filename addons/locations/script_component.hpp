#define COMPONENT locations
#include "\z\afmf\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#include "\z\afmf\addons\main\script_macros.hpp"

#define NAMED_LOCATIONS ["nameVillage", "nameCity", "nameCityCapital", "nameLocal", "nameMarine"]
#define NEAREST_LOCATION(VAR) (nearestLocation [getPosATL VAR, NAMED_LOCATIONS, 2000])
