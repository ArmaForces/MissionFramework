#define COMPONENT arsenal
#include "\z\afmf\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

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

#define IDC_buttonPrimaryWeapon 2002
#define IDC_buttonHandgun 2004
#define IDC_buttonSecondaryWeapon 2006
#define IDC_buttonHeadgear 2008
#define IDC_buttonUniform 2010
#define IDC_buttonVest 2012
#define IDC_buttonBackpack 2014
#define IDC_buttonGoggles 2016
#define IDC_buttonNVG 2018
#define IDC_buttonBinoculars 2020
#define IDC_buttonMap 2022
#define IDC_buttonGPS 2024
#define IDC_buttonRadio 2026
#define IDC_buttonCompass 2029
#define IDC_buttonWatch 2031
#define IDC_buttonFace 2033
#define IDC_buttonVoice 2035
#define IDC_buttonInsignia 2037

#define ATTRIBUTE_CATEGORIES_DEFAULT_VALUE \
    [\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        true,\
        false,\
        false,\
        false\
    ]

#define ARSENAL_CATEGORIES_IDCS \
    [\
        IDC_buttonPrimaryWeapon,\
        IDC_buttonHandgun,\
        IDC_buttonSecondaryWeapon,\
        IDC_buttonHeadgear,\
        IDC_buttonUniform,\
        IDC_buttonVest,\
        IDC_buttonBackpack,\
        IDC_buttonGoggles,\
        IDC_buttonNVG,\
        IDC_buttonBinoculars,\
        IDC_buttonMap,\
        IDC_buttonGPS,\
        IDC_buttonRadio,\
        IDC_buttonCompass,\
        IDC_buttonWatch,\
        IDC_buttonFace,\
        IDC_buttonVoice,\
        IDC_buttonInsignia\
    ]

#define IDC_ATTRIBUTE_CATEGORIES 100
