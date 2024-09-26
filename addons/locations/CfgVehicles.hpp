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

    class GVAR(editModule): Module_F {
        scope = 2;
    };
};
