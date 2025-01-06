#include "\a3\ui_f\hpp\definedikcodes.inc"

class ctrlMenuStrip;

class Display3DEN
{
    class Controls
    {
        class MenuStrip: ctrlMenuStrip
        {
            class Items
            {
                class Tools
                {
                    items[] +=
                    {
                        "PG_Folder_PathCreator"
                    };
                };
                class PG_Folder_PathCreator
                {
                    text = "Path Creator";
                    picture = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\open_ca.paa";
                    items[] +=
                    {
                        "PG_NewPath",
                        "PG_CreatePoint",
                        "PG_ToggleControlPointsBehaviour"
                    };
                };
                class PG_NewPath
                {
                    text = "Create New Path";
                    action = "call PG_fnc_main";
                    shortcuts[] = {INPUT_ALT_OFFSET + DIK_P};
                };
                class PG_CreatePoint
                {
                    text = "Create Point";
                    action = "call PG_fnc_createSegment";
                    shortcuts[] = {INPUT_ALT_OFFSET + DIK_SPACE};
                };
                class PG_ToggleControlPointsBehaviour
                {
                    text = "Toggle Control Point Behaviour";
                    action = "_this call PG_fnc_toggleControlPointBehaviour";
                    shortcuts[] = {INPUT_ALT_OFFSET + DIK_U};
                };
            };
        };
    };
};
