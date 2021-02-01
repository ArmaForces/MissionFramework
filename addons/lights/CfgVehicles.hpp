class CfgVehicles {
    class House;
    class House_F: House {
        class ACE_Actions;
    };
    class Land_GuardTower_02_F: House_F {
        class ACE_Actions: ACE_Actions {
            class GVAR(lightsOn1) {
                displayName = "$STR_ACTION_LIGHTS_ON";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\beacons_ON_ca.paa";

                distance = 2;

                condition = QUOTE(_target animationPhase 'lights_hide' == 0 && {lightIsOn _target == 'OFF'});
                position = QUOTE(_target selectionPosition [ARR_2('light_1_hitpoint', 'HitPoints')]);
                statement = QUOTE([ARR_2(_target, 'ON')] call FUNC(switchLight));
            };
            class GVAR(lightsOff1): GVAR(lightsOn1) {
                displayName = "$STR_ACTION_LIGHTS_OFF";
                icon = "\a3\ui_f\data\IGUI\Cfg\Actions\beacons_OFF_ca.paa";

                condition = QUOTE(_target animationPhase 'lights_hide' == 0 && {lightIsOn _target == 'ON'});
                statement = QUOTE([ARR_2(_target, 'OFF')] call FUNC(switchLight));
            };

            class GVAR(lightsOn2): GVAR(lightsOn1) {
                position = QUOTE(_target selectionPosition [ARR_2('light_2_hitpoint', 'HitPoints')]);
            };
            class GVAR(lightsOff2): GVAR(lightsOff1) {
                position = QUOTE(_target selectionPosition [ARR_2('light_2_hitpoint', 'HitPoints')]);
            };

            class GVAR(lightsOn3): GVAR(lightsOn1) {
                position = QUOTE(_target selectionPosition [ARR_2('light_3_hitpoint', 'HitPoints')]);
            };
            class GVAR(lightsOff3): GVAR(lightsOff1) {
                position = QUOTE(_target selectionPosition [ARR_2('light_3_hitpoint', 'HitPoints')]);
            };
        };
    };
};
