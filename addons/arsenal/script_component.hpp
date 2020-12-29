#define COMPONENT arsenal
#include "\z\afmf\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_ARSENAL
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_ARSENAL
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ARSENAL
#endif

#include "\z\afmf\addons\main\script_macros.hpp"

// 3DEN Attribute
#define ATTRIBUTE_W (pixelW * pixelGrid * 0.5)
#define ATTRIBUTE_H (pixelH * pixelGrid * 0.5)

#define ATTRIBUTE_CATEGORIES_DEFAULT_VALUE [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false]

#define IDC_ATTRIBUTE_CATEGORIES 100
