class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Checkbox;
            class Edit;
            class Units;
            class Combo;
            class ModuleDescription;

            class GVAR(supplyClasses): Default {
                control = QGVAR(supplyClasses);
                defaultValue = "'[]'";
                expression = "_this setVariable ['%s', parseSimpleArray _value]";
                validate = "none";
            };
        };

        class ModuleDescription;
        class EventHandlers;
    };

    class GVAR(areaModule): Module_F {
        scope = 2;
        displayName = CSTRING(AreaModule_DisplayName);
        category = QUOTE(PREFIX);

        function = QFUNC(areaModule);

        isGlobal = 0;
        isDisposable = 1;
        isTriggerActivated = 1;

        canSetArea = 1;
        canSetAreaHeight = 1;
        canSetAreaShape = 1;

        class EventHandlers: EventHandlers {
            class ADDON {
                attributesChanged3DEN = QUOTE(call FUNC(3denValidate));
            };
        };

        class AttributeValues {
            size3[] = {25, 25, 15};
            isRectangle = 0;
        };

        class Attributes: AttributesBase {
            class GVAR(layer): Combo {
                displayName = CSTRING(AreaModule_Attribute_Layer);
                tooltip = CSTRING(AreaModule_Attribute_Layer_Description);

                control = QGVAR(Layers);

                property = QGVAR(layer);
            };

            class GVAR(supplyCrates): GVAR(supplyClasses) {
                defaultValue = "'[""B_supplyCrate_F""]'";

                property = QGVAR(supplyCrates);
            };

            class GVAR(requiredSupplies): Edit {
                displayName = CSTRING(AreaModule_Attribute_requiredSupplies);
                tooltip = CSTRING(AreaModule_Attribute_requiredSupplies_Description);

                property = QGVAR(requiredSupplies);

                validate = "number";
                defaultValue = "1";
            };

            class GVAR(buildTime): Edit {
                displayName = CSTRING(AreaModule_Attribute_BuildTime);
                tooltip = CSTRING(AreaModule_Attribute_BuildTime_Description);

                property = QGVAR(buildTime);

                validate = "number";
                defaultValue = "60";
            };

            class GVAR(hideObjects): Checkbox {
                displayName = CSTRING(AreaModule_Attribute_HideObjects);
                tooltip = CSTRING(AreaModule_Attribute_HideObjects_Description);

                property = QGVAR(hideObjects);

                defaultValue = "true";
            };

            class GVAR(onBuilt): Default {
                displayName = CSTRING(AreaModule_Attribute_OnBuilt);
                tooltip = CSTRING(AreaModule_Attribute_OnBuilt_Description);

                property = QGVAR(onBuilt);

                control = "EditCodeMulti5";
                validate = "expression";

                defaultValue = "''";
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(AreaModule_Description);
            direction = 1;
            position = 1;
        };
    };
};
