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
        };

        class ModuleDescription;
        class EventHandlers;
    };

    class GVAR(createModule): Module_F {
        scope = 2;
        // displayName = CSTRING(Module_DisplayName);
        displayName = "TEST";
        category = QUOTE(PREFIX);

        function = QFUNC(createModule);

        isGlobal = 0;
        isDisposable = 1;

        class EventHandlers: EventHandlers {
            class ADDON {
                // init = QUOTE(if (is3DEN) then {call FUNC(module)});
                // registeredToWorld3DEN = QUOTE(call FUNC(module));
            };
        };
    };
};
