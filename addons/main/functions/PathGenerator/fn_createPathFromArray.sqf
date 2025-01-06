params ["_points"];

diag_log _points;

PG_Points = [];
PG_LookUpTable = createHashMap;

{
    if (_forEachIndex call PG_fnc_isAnchorPoint) then
    {
        [_x, true, _forEachIndex] call PG_fnc_createAnchorPoint;
    }
    else
    {
        [_x, true, _forEachIndex] call PG_fnc_createControlPoint;
    };
} forEach _points;
