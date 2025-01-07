// Reset all variables except functions
allVariables missionNamespace apply
{
    if (_x select [0, 3] == "pg_" && {!("_fnc_" in _x)}) then
    {
        missionNamespace setVariable [_x, nil];
    };
};

ignore3DENHistory
{
    // Clear layer if it exists
    delete3DENEntities (get3DENLayerEntities (call PG_fnc_getPointsLayer));

    // Delete layer
    remove3DENLayer (call PG_fnc_getPointsLayer);
};

call PG_fnc_initVariables;
