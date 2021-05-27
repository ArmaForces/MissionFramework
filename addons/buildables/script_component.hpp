#define COMPONENT buildables
#include "\z\afmf\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#include "\z\afmf\addons\main\script_macros.hpp"

// 3DEN Attribute
#define ATTRIBUTE_W (pixelW * pixelGrid * 0.5)
#define ATTRIBUTE_H (pixelH * pixelGrid * 0.5)

#define IDC_ATTRIBUTE_SUPPLYCLASSES_CLASSES 100
#define IDC_ATTRIBUTE_SUPPLYCLASSES_LIST 101

#define AREA_ID_KEY "area"
#define AREA_ID(HASH) (HASH get AREA_ID_KEY)
