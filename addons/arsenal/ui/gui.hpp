class ctrlControlsGroupNoScrollbars;
class ctrlToolboxPictureKeepAspect;
class ctrlStatic;
// there's no base class for CT_CHECKBOXES so we need to create one
class GVAR(checkboxes) {
    type = CT_CHECKBOXES;
    // style = "0x02 + 0x30 + 0x800";
    style = QUOTE(ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO);

    x = 0.25;
    y = 0.25;
    w = 0.5;
    h = 0.5;

    colorText[] = {1,0,0,1};
    colorTextSelect[] = {1,1,1,1};

    colorBackground[] = {0,0,0,0.5};
    colorSelectedBg[] = GUI_BCG_COLOR;

    font = "RobotoCondensed";
    sizeEx = "4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5";

    onCheckBoxesSelChanged = "";

    columns = 1;
    rows = 1;

    strings[] = {};
    checked_strings[] = {};
    values[] = {};
    tooltips[] = {};
};
