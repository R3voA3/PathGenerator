if (get3DENActionState "togglemap" == 0) then
{
    do3DENAction "toggleMap";
};

call PG_fnc_reset;
call PG_fnc_initVariables;
[call PG_fnc_getMouseToWorldPos] call PG_fnc_createSegment
