with uiNamespace do
{
    params ["_position", ["_isNew", true], ["_oldIndex", -1]];

    private _anchorPoint = objNull;

    ignore3DENHistory
    {
        _anchorPoint = create3DENEntity ["Logic", "SideOPFOR_F", _position];
        _anchorPoint set3DENLayer (call PG_fnc_getPointsLayer);
    };

    if _isNew then
    {
        PG_Points append [getPosATL _anchorPoint];
    };

    // If we create entities from existing path then we reuse the old index
    private _index = if (_oldIndex > -1) then {_oldIndex} else {count PG_Points - 1};

    PG_LookUpTable set [get3DENEntityID _anchorPoint, _index];

    _anchorPoint call PG_fnc_addEventHandlers;

    _anchorPoint
};
