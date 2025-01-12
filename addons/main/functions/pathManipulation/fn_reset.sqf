// Reset all variables except functions
allVariables uiNamespace apply
{
    if (_x select [0, 3] == "pg_" && {!("_fnc_" in _x)}) then
    {
        uiNamespace setVariable [_x, nil];
    };
};

call PG_fnc_removePathLayer;
call PG_fnc_initVariables;
