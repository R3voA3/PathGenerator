#include "\a3\3den\ui\resincl.inc"

call PG_fnc_initVariables;

diag_log "Path Generator: Variables initialized";

onEachFrame
{
    private _3DENMap = findDisplay IDD_DISPLAY3DEN displayCtrl IDC_DISPLAY3DEN_MAP;

    if (!isNull _3DENMap) then
    {
        onEachFrame {};

        diag_log "Path Generator: 3DEN map available. Adding draw EH.";

        (findDisplay IDD_DISPLAY3DEN displayCtrl IDC_DISPLAY3DEN_MAP) ctrlAddEventHandler ["Draw",
        {
            _this call PG_fnc_draw;
        }];
    };
};
