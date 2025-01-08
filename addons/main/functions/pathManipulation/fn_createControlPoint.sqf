params ["_position", ["_isNew", true], ["_oldIndex", -1]];

private _controlPoint = objNull;

ignore3DENHistory
{
    _controlPoint = create3DENEntity ["Logic", "Logic", _position];
    _controlPoint set3DENAttribute ["name", format ["Index_%1", count PG_Points]];
    _controlPoint set3DENLayer (call PG_fnc_getPointsLayer);
};

if _isNew then
{
    PG_Points append [getPosATL _controlPoint];
};

// If we create entities from existing path then we reuse the old index
private _index = if (_oldIndex > -1) then {_oldIndex} else {count PG_Points - 1};

PG_LookUpTable set [get3DENEntityID _controlPoint, _index];

_controlPoint call PG_fnc_addEventHandlers;

_controlPoint
