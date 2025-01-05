params ["_pointEntity"];

private _index = [_pointEntity] call PG_fnc_getPointEntityIndex;

if (_index mod 3 == 0) then
{

};

// When a control point is deleted, it's anchor and all its other control points get deleted as well
// Update PG_Points
