#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Display refresh interval. Changing it after setup won't work correctly.
GVAR(displayProgressOnScreenRefreshInterval) = PROGRESS_INTERVAL;

ADDON = true;
