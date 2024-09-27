class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Checkbox;
            class Edit;
            class Units;
            class Combo;
            class Title;
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

    class GVAR(editModule): Module_F {
        scope = 2;
        displayName = CSTRING(EditModule_DisplayName);
        category = QUOTE(PREFIX);

        function = QFUNC(editModule);

        isGlobal = 2;
        isDisposable = 1;

        class EventHandlers: EventHandlers {
            class ADDON {
                init = QUOTE(if (is3DEN) then {call FUNC(editModule_updateLocation)});
                attributesChanged3DEN = QUOTE(call FUNC(editModule_updateLocation));
                registeredToWorld3DEN = QUOTE(call FUNC(editModule_updateLocation));
            };
        };

        class Attributes: AttributesBase {
            class GVAR(location): Edit {
                displayName = CSTRING(AreaModule_Attribute_Location);

                control = QGVAR(EditDisabled);
                property = QGVAR(location);
            };

            class GVAR(name): Edit {
                displayName = CSTRING(AreaModule_Attribute_Name);

                property = QGVAR(name);
            };

            class GVAR(hide): Checkbox {
                displayName = CSTRING(AreaModule_Attribute_Hide);

                property = QGVAR(hide);
            };
        };
    };
};
