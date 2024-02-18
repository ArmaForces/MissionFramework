#define COMPONENT task_download
#include "\z\afmf\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_TASK_DOWNLOAD
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_TASK_DOWNLOAD
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TASK_DOWNLOAD
#endif

#include "\z\afmf\addons\main\script_macros.hpp"

#define INITIAL_PROGRESS 0
#define MAX_PROGRESS 100
#define PROGRESS_INTERVAL 1
#define ACTION_TYPE 0
