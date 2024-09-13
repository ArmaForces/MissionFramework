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
                    onLoad = QUOTE(call (uiNamespace getVariable QQFUNC(attributeLayersLoad)));
                };
            };
        };

        class GVAR(supplyClasses): ctrlControlsGroupNoScrollbars {

            idc = -1;

            x = QUOTE(0);
            y = QUOTE(0);
            w = QUOTE(130 * ATTRIBUTE_W);
            h = QUOTE((10 + 5 + 5 + 25) * ATTRIBUTE_H);

            attributeLoad = QUOTE([ARR_2(_this,_value)] call FUNC(attributeSupplyClassesLoad));
            attributeSave = QUOTE([_this] call FUNC(attributeSupplyClassesSave));

            class Controls {
                #define COL_W 55
                #define BTN_W ((125 - (COL_W * 2)) / 2)

                class CategoriesTitle: ctrlStatic {
                    idc = -1;

                    text = CSTRING(AreaModule_Attribute_SupplyCrates);
                    tooltip = CSTRING(AreaModule_Attribute_SupplyCrates_Description);

                    x = QUOTE(5 * ATTRIBUTE_W);
                    y = QUOTE(0);
                    w = QUOTE(125 * ATTRIBUTE_W);
                    h = QUOTE(5 * ATTRIBUTE_H);
                };

                class ClassesSearch: ctrlEdit {
                    idc = 123;

                    x = QUOTE((5 + 2.5) * ATTRIBUTE_W);
                    y = QUOTE(7 * ATTRIBUTE_H);
                    w = QUOTE(COL_W * ATTRIBUTE_W);
                    h = QUOTE(5 * ATTRIBUTE_H);

                    tooltip = "Type to search";
                };
                class ClassesTree: ctrlTree {
                    idc = 100;
                    idcSearch = 123;

                    onLoad = QUOTE(_this call FUNC(attributeSupplyClassesClassesLoad));

                    colorBackground[] = {0,0,0,0.5};

                    x = QUOTE((5 + 2.5) * ATTRIBUTE_W);
                    y = QUOTE(14 * ATTRIBUTE_H);
                    w = QUOTE(COL_W * ATTRIBUTE_W);
                    h = QUOTE(25 * ATTRIBUTE_H);
                };

                class ButtonAdd: ctrlButton {
                    text = "+";

                    onButtonClick = QUOTE(_this call FUNC(attributeSupplyClassesAdd));

                    x = QUOTE((COL_W + BTN_W / 2 + BTN_W / 3 + 2.5) * ATTRIBUTE_W);
                    y = QUOTE(20 * ATTRIBUTE_H);
                    w = QUOTE(BTN_W * ATTRIBUTE_W);
                    h = QUOTE(BTN_W * ATTRIBUTE_W);
                };
                class ButtonRemove: ctrlButton {
                    text = "-";

                    onButtonClick = QUOTE(_this call FUNC(attributeSupplyClassesRemove));

                    x = QUOTE((COL_W + BTN_W / 2 + BTN_W / 3 + 2.5) * ATTRIBUTE_W);
                    y = QUOTE(30 * ATTRIBUTE_H);
                    w = QUOTE(BTN_W * ATTRIBUTE_W);
                    h = QUOTE(BTN_W * ATTRIBUTE_W);
                };

                class SelectedList: ctrlListbox {
                    idc = 101;

                    x = QUOTE((70 + 2.5) * ATTRIBUTE_W);
                    y = QUOTE(14 * ATTRIBUTE_H);
                    w = QUOTE(COL_W * ATTRIBUTE_W);
                    h = QUOTE(25 * ATTRIBUTE_H);
                };
            };
        };
    };
};
