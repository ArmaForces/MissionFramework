class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Checkbox;
            class ModuleDescription;
        };

        class ModuleDescription {};
    };

    class GVAR(arsenal): Module_F {
        scope = 2;
        displayName = CSTRING(Module_DisplayName);
        category = QUOTE(PREFIX);

        function = QFUNC(arsenalModule);

        isGlobal = 0;
        isDisposable = 1;
        // custom trigger activation handling in code
        isTriggerActivated = 0;

        class Attributes: AttributesBase {
            class GVAR(deleteUnits): Checkbox {
                displayName = CSTRING(Module_Attribute_DeleteUnits);
                property = QGVAR(deleteUnits);
                tooltip = CSTRING(Module_Attribute_DeleteUnits_Description);
                defaultValue = "true";
            };

            class GVAR(playerItems): Checkbox {
                displayName = CSTRING(Module_Attribute_PlayerItems);
                property = QGVAR(playerItems);
                tooltip = CSTRING(Module_Attribute_PlayerItems_Description);
                defaultValue = "true";
            };

            class GVAR(allGoggles): Checkbox {
                displayName = CSTRING(Module_Attribute_AllGoggles);
                property = QGVAR(allGoggles);
                tooltip = CSTRING(Module_Attribute_AllGoggles_Description);
                defaultValue = "true";
            };

            class ModuleDescription: ModuleDescription {};
        };

        // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
        class ModuleDescription: ModuleDescription {
            description[] = {
                CSTRING(Module_Description_UnitsObjects),
                "",
                CSTRING(Module_Description_Inventories),
                "",
                CSTRING(Module_Description_Multiple)
            };
        };
    };
};
