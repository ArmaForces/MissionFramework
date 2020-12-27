class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Checkbox;
            class ModuleDescription;
        };
    };

    class GVAR(arsenal): Module_F {
        scope = 2;
        displayName = "Arsenal";
        category = "afm";

        function = QFUNC(arsenalModule);

        isGlobal = 0;
        isDisposable = 1;

        class Attributes: AttributesBase {
            class GVAR(deleteUnits): Checkbox {
                displayName = "Delete units";
                property = QGVAR(deleteUnits);
                tooltip = "Should synchronized units be deleted after the arsenal is created";
                defaultValue = "true";
            };

            class GVAR(playerItems): Checkbox {
                displayName = "Add player items";
                property = QGVAR(playerItems);
                tooltip = "Should items from player loadout be added to arsenal (local effect)";
                defaultValue = "true";
            };

            class ModuleDescription: ModuleDescription {};
        };
    };
};
