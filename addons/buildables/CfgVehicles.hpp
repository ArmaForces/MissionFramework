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

            class GVAR(Layers): Combo {
                control = QGVAR(Layers);
            };
            class GVAR(Number): Edit {
                // control = QGVAR(Number);
                validate = "number";
                defaultValue = "0";
            };
        };

        class ModuleDescription {};
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

        class AttributeValues {
            size3[] = {25, 25, 15};
            isRectangle = 0;
        };

        class Attributes: AttributesBase {
            class GVAR(layer): GVAR(Layers) {
                displayName = CSTRING(AreaModule_Attribute_Layer);
                tooltip = CSTRING(AreaModule_Attribute_Layer_Description);

                property = QGVAR(layer);
            };

            class GVAR(supplyCrates): Edit {
                displayName = CSTRING(AreaModule_Attribute_supplyCrates);
                tooltip = CSTRING(AreaModule_Attribute_supplyCrates_Description);

                property = QGVAR(supplyCrates);
            };

            class GVAR(requiredSupplies): Edit {
                displayName = CSTRING(AreaModule_Attribute_requiredSupplies);
                tooltip = CSTRING(AreaModule_Attribute_requiredSupplies_Description);

                property = QGVAR(requiredSupplies);

                validate = "number";
                defaultValue = "1";
                expression = "_this setVariable ['%s',_value max 1];";
            };

            class GVAR(buildTime): Edit {
                displayName = CSTRING(AreaModule_Attribute_BuildTime);
                tooltip = CSTRING(AreaModule_Attribute_BuildTime_Description);

                property = QGVAR(buildTime);

                validate = "number";
                defaultValue = "60";
                expression = "_this setVariable ['%s',_value max 0];";
            };

            class GVAR(hideObjects): Checkbox {
                displayName = CSTRING(AreaModule_Attribute_HideObjects);
                tooltip = CSTRING(AreaModule_Attribute_HideObjects_Description);

                property = QGVAR(hideObjects);

                defaultValue "true";
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                CSTRING(AreaModule_Description)
            };
        };
    };
};
