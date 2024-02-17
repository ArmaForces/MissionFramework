#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Complete download automatically. If false, someone needs to check status of the download when it's completed for success to trigger.
GVAR(automaticCompletion) = false;

// Show progress to everyone. If false, show progress action must be used.
GVAR(showProgressToAll) = false;

ADDON = true;
