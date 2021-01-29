class Cfg3DEN {
    class Attributes {
        class GVAR(categories): ctrlControlsGroupNoScrollbars {
            idc = -1;

            x = QUOTE(0);
            y = QUOTE(0);
            w = QUOTE(130 * ATTRIBUTE_W);
            h = QUOTE(19 * ATTRIBUTE_H);

            attributeLoad = QUOTE([ARR_2(_this,_value)] call FUNC(attributeCategoriesLoad));
            attributeSave = QUOTE(_this call FUNC(attributeCategoriesSave));

            class controls {
                class CategoriesTitle: ctrlStatic {
                    idc = -1;

                    text = CSTRING(3DEN_Categories);
                    tooltip = CSTRING(3DEN_Categories_Tooltip);

                    x = QUOTE(5 * ATTRIBUTE_W);
                    y = QUOTE(0);
                    w = QUOTE(125 * ATTRIBUTE_W);
                    h = QUOTE(5 * ATTRIBUTE_H);
                };
                class Categories: GVAR(checkboxes) {
                    idc = IDC_ATTRIBUTE_CATEGORIES;

                    x = QUOTE(5 * ATTRIBUTE_W);
                    y = QUOTE(7 * ATTRIBUTE_H);
                    w = QUOTE(125 * ATTRIBUTE_W);
                    h = QUOTE(10 * ATTRIBUTE_H);

                    colorSelectedBg[] = {0,0,0,0.5};

                    onCheckBoxesSelChanged = QUOTE(call FUNC(attributeCategoriesValidate));

                    rows = 1;
                    columns = 18;

                    strings[] = {
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Headgear_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Uniform_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Vest_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Backpack_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Goggles_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\NVGs_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Binoculars_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Map_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\GPS_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Radio_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Compass_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Watch_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Face_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Voice_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Insignia_ca.paa"
                    };
                    tooltips[] = {
                        "$STR_A3_RscDisplayArsenal_tab_PrimaryWeapon",
                        "$STR_A3_RscDisplayArsenal_tab_Handgun",
                        "$STR_A3_RscDisplayArsenal_tab_SecondaryWeapon",
                        "$STR_A3_RscDisplayArsenal_tab_Headgear",
                        "$STR_A3_RscDisplayArsenal_tab_Uniform",
                        "$STR_A3_RscDisplayArsenal_tab_Vest",
                        "$STR_A3_RscDisplayArsenal_tab_Backpack",
                        "$STR_A3_RscDisplayArsenal_tab_Goggles",
                        "$STR_A3_RscDisplayArsenal_tab_NVGs",
                        "$STR_A3_RscDisplayArsenal_tab_Binoculars",
                        "$STR_A3_RscDisplayArsenal_tab_Map",
                        "$STR_A3_RscDisplayArsenal_tab_GPS",
                        "$STR_A3_RscDisplayArsenal_tab_Radio",
                        "$STR_A3_RscDisplayArsenal_tab_Compass",
                        "$STR_A3_RscDisplayArsenal_tab_Watch",
                        "$STR_A3_RscDisplayArsenal_tab_Face",
                        "$STR_A3_RscDisplayArsenal_tab_Voice",
                        "$STR_A3_RscDisplayArsenal_tab_Insignia"
                    };
                };
            };
        };
    };
};
