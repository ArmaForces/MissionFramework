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
    };
};
