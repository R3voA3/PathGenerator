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
                class Separator;
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
                        "PG_ToggleControlPointsBehaviour",
                        "Separator",
                        "PG_CalculateEvenlySpacedPoints",
                        "PG_Reset",
                        "Separator",
                        "PG_SavePath",
                        "PG_LoadPath",
                        "Separator",
                        "PG_CreateRandomPath"
                    };
                };
                class PG_NewPath
                {
                    text = "Create New Path";
                    action = "call PG_fnc_main";
                };
                class PG_CreatePoint
                {
                    text = "Create Point";
                    action = "[call PG_fnc_getMouseToWorldPos] call PG_fnc_createSegment";
                    shortcuts[] = {INPUT_ALT_OFFSET + DIK_SPACE};
                };
                class PG_ToggleControlPointsBehaviour
                {
                    text = "Toggle Control Point Behaviour";
                    action = "_this call PG_fnc_toggleControlPointBehaviour";
                    shortcuts[] = {INPUT_ALT_OFFSET + DIK_U};
                };
                class PG_CalculateEvenlySpacedPoints
                {
                    text = "Toggle Control Point Behaviour";
                    action = "[10] spawn PG_fnc_getEvenlySpacedPoints";
                };
                class PG_Reset
                {
                    text = "Reset everything";
                    action = "call PG_fnc_reset";
                };
                class PG_SavePath
                {
                    text = "Save Path";
                    picture = "a3\3den\data\displays\display3den\toolbar\saveas_ca.paa";
                    action = "call PG_fnc_savePath";
                };
                class PG_LoadPath
                {
                    text = "Load Path";
                    action = "call PG_fnc_loadPath";
                };
                class PG_CreateRandomPath
                {
                    text = "Create Random Path";
                    action = "50 call PG_fnc_createRandomPath";
                };
            };
        };
    };
};
