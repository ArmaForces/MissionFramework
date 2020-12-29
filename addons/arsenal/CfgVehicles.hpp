class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Checkbox;
            class ModuleDescription;

            class GVAR(categories): Default {
                control = QGVAR(categories);
                displayName = CSTRING(3DEN_Categories);
                defaultValue = QUOTE('ATTRIBUTE_CATEGORIES_DEFAULT_VALUE');
                expression = QUOTE(_this setVariable [ARR_2('%s',parseSimpleArray _value)]);
                validate = "none";
            };
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
            class GVAR(categories): GVAR(categories) {
                displayName = CSTRING(3DEN_Categories);
                property = QGVAR(categories);
            };

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
