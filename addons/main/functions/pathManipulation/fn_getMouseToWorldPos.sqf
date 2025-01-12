#include "\a3\3den\ui\resincl.inc"

private _ctrlMap = findDisplay IDD_DISPLAY3DEN displayCtrl IDC_DISPLAY3DEN_MAP;

if (get3DENActionState "togglemap" > 0) exitWith
{
    (_ctrlMap ctrlMapScreenToWorld getMousePosition) + [0];
};

[0, 0, 0];
