params ["_pointEntity"];

private _index = [_pointEntity] call PG_fnc_getPointEntityIndex;

// Some entity not related to our path was deleted
if (_index == -1) exitWith {};

if (_index call PG_fnc_isAnchorPoint) then
{

};

// When a control point is deleted, it's anchor and all its other control points get deleted as well
// Update PG_Points
