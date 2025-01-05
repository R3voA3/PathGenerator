#include "\a3\ui_f\hpp\definedikcodes.inc"

private _display = findDisplay 313;
private _menuStrip = _display displayCtrl 120;

private _index = _menuStrip menuAdd [[], "Path Generator"];

private _indexItem = _menuStrip menuAdd [[_index], "Create New Path"];
_menuStrip menuSetAction [[_index, _indexItem], "call PG_fnc_main"];
_menuStrip menuSetShortcut [[_index, _indexItem], INPUT_ALT_OFFSET + DIK_N];
