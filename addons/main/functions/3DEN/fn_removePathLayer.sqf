ignore3DENHistory
{
    private _layer = call PG_fnc_getPointsLayer;

    // Clear layer if it exists
    delete3DENEntities (get3DENLayerEntities _layer);

    // Delete layer and all its children
    remove3DENLayer _layer;
};
