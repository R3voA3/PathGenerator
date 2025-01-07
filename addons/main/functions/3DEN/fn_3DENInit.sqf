#include "\a3\3den\ui\resincl.inc"

params ["_display3DEN"];

(_display3DEN displayCtrl IDC_DISPLAY3DEN_MAP) ctrlAddEventHandler ["Draw",
{
    _this call PG_fnc_draw;
}]
