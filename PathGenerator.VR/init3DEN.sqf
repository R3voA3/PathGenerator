private _display3DEN = findDisplay 313;

if !(_display3DEN getVariable ["PG_MenuStripEdited", false]) then
{
    call PG_fnc_menuStrip;
    _display3DEN setVariable ["PG_MenuStripEdited", true];
};
