 class ZEN_WaypointTypes {
    class GVAR(VehicleMove) {
            displayName = CSTRING(VehicleMoveName);
            type = "SCRIPTED";
            script = QPATHTOF(functions\fnc_waypointMoveVehicle.sqf);
        };
};
