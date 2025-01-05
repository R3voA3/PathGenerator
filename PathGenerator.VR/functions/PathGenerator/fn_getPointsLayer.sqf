#define LAYER "PG: Points"

private _layerID = -1;

{
    if (((_x get3DENAttribute "name") select 0) == LAYER) exitWith
    {
        _layerID = get3DENEntityID _x;
    };
} forEach (all3DENEntities select 6);

if (_layerID == -1) then
{
    ignore3DENHistory
    {
        _layerID = -1 add3DENLayer LAYER;
    };
};

_layerID
