params ["_pointEntity"];

private _index = [get3DENEntityID _pointEntity] call PG_fnc_getPointEntityIndex;

// Dragging an entity not related to the path
if (_index == -1) exitWith {};

private _currentPosition = PG_Points select _index;
private _newPosition = _pointEntity get3DENAttribute "position" select 0;
private _posDelta = (_currentPosition vectorDiff _newPosition) vectorMultiply -1; // Negate numbers otherwise we rotate around the center of both points

if (_posDelta isEqualTo [0, 0, 0]) exitWith {};

PG_Points set [_index, _newPosition];

if (_index % 3 == 0) then // Anchor point
{
    if (_index == 0) then // First anchor point in path, no previous control point
    {
        private _controlPoint = [_index + 1] call PG_fnc_getPointEntityFromIndex;
        private _OldControlPointPosition = PG_Points select (_index + 1);
        private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

        PG_Points set [_index + 1, _newControlPointPosition];
        ignore3DENHistory {_controlPoint set3DENAttribute ["position", _newControlPointPosition]};
    };
    if (_index == (count PG_Points - 1)) then // Last anchor point. Only a previous control point
    {
        private _controlPoint = [_index - 1] call PG_fnc_getPointEntityFromIndex;
        private _OldControlPointPosition = PG_Points select (_index - 1);
        private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

        PG_Points set [_index - 1, _newControlPointPosition];
        ignore3DENHistory {_controlPoint set3DENAttribute ["position", _newControlPointPosition]};
    };
    if (_index > 0 && _index < (count PG_Points - 1)) then // Two anchor points (_index - 1, _index + 1)
    {
        private _controlPoint = [_index + 1] call PG_fnc_getPointEntityFromIndex;
        private _OldControlPointPosition = PG_Points select (_index + 1);
        private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

        PG_Points set [_index + 1, _newControlPointPosition];
        ignore3DENHistory {_controlPoint set3DENAttribute ["position", _newControlPointPosition]};

        private _controlPoint = [_index - 1] call PG_fnc_getPointEntityFromIndex;
        private _OldControlPointPosition = PG_Points select (_index - 1);
        private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

        PG_Points set [_index - 1, _newControlPointPosition];
        ignore3DENHistory {_controlPoint set3DENAttribute ["position", _newControlPointPosition]};
    };
}
else // Control points
{
    if (!PG_ShiftToggled && {_index > 1 && {_index < (count PG_Points - 2)}}) then // The first and last control points don't have a partner
    {
        // In order to find out if we need to
        // increase or decrease the _index to find the other control point
        // we check in which direction the anchor point lies
        private _indexOtherControlPoint =
        if ((_index + 1) call PG_fnc_isAnchorPoint) then
        {
            _index + 2;
        }
        else
        {
            _index - 2
        };

        private _controlPoint = [_indexOtherControlPoint] call PG_fnc_getPointEntityFromIndex;
        private _OldControlPointPosition = PG_Points select _indexOtherControlPoint;
        private _newControlPointPosition = _OldControlPointPosition vectorAdd (_posDelta vectorMultiply -1);

        PG_Points set [_indexOtherControlPoint, _newControlPointPosition];
        ignore3DENHistory {_controlPoint set3DENAttribute ["position", _newControlPointPosition]};
    };
};
