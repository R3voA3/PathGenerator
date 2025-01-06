#include "\a3\3den\ui\resincl.inc"

params ["_display3DEN"];

(_display3DEN displayCtrl IDC_DISPLAY3DEN_MAP) ctrlAddEventHandler ["Draw",
{
    call PG_fnc_drawPath;
    _this call PG_fnc_drawConnections;
}]
