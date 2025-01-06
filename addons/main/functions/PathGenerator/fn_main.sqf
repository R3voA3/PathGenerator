if (get3DENActionState "togglemap" == 0) then
{
    do3DENAction "toggleMap";
};

// Clear layer if it exists
delete3DENEntities (get3DENLayerEntities (call PG_fnc_getPointsLayer));

call PG_fnc_initVariables;