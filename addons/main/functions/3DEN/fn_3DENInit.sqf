#include "\a3\3den\ui\resincl.inc"

call PG_fnc_initVariables;
call PG_fnc_initSettings;

(findDisplay IDD_DISPLAY3DEN displayCtrl IDC_DISPLAY3DEN_MAP) ctrlAddEventHandler ["Draw",
{
    _this call PG_fnc_draw;
}];
