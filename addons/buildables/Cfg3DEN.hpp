class Cfg3DEN {
    class Attributes {
        class Default;
        class Title: Default {
            class Controls;
        };
        class Edit: Title {
            class Controls: Controls {
                class Title;
                class Value;
            };
        };
        class Combo: Title {
            class Controls: Controls {
                class Title;
                class Value;
            };
        };
        class GVAR(Layers): Combo {
            attributeSave = QUOTE(_ctrlCombo = _this controlsGroupCtrl 100; _ctrlCombo lbData lbCurSel _ctrlCombo);

            class Controls: Controls {
                class Title: Title {};
                class Value: Value {
                    onLoad = QUOTE(call (uiNamespace getVariable QQFUNC(attributeModuleLayersLoad)));
                };
            };
        };
    };
};
