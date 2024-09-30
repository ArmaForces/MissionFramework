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

        class GVAR(EditDisabled): Edit {
            class Controls: Controls {
                class Title: Title {};
                class Value: Value {
                    onLoad = "(_this#0) ctrlEnable false";
                };
            };
        };
    };
};
