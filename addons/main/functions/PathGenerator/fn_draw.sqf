params ["_ctrlMap"];

if (PG_Points isEqualTo []) exitWith {};

// Draw connections
for "_index" from 0 to (count PG_Points - 1) do
{
    if (_index call PG_fnc_isAnchorPoint) then
    {
        if (_index == 0) then // First anchor point, no previous control point
        {
            _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index + 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
        }
        else
        {
            if (_index == (count PG_Points - 1)) then // Last anchor point, no following control point
            {
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index - 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
            }
            else // Some anchor point in the middle, previous and following control points are present
            {
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index + 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index - 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
            };
        };
    };
};

// Draw curve
PG_InterpolatedPath = [];

for "_i" from 0 to (call PG_fnc_getSegmentCount - 1) do
{
    private _points = _i call PG_fnc_getPointsInSegment;

    for "_progress" from 0 to 1 step PG_BezierResolution do
    {
        PG_InterpolatedPath pushBack (_progress bezierInterpolation
        [
            _points select 0,
            _points select 1,
            _points select 2,
            _points select 3
        ]);
    };
};

// Million times faster than drawing each line but only supports closed paths
// findDisplay 313 displayCtrl 51 drawPolygon [PG_InterpolatedPath, [0, 0, 1, 1]];

private _previousPoint = PG_InterpolatedPath # 0;

// Limited reached with 8500 points
private _maxIndex = count PG_InterpolatedPath - 1;
private _colorPoints = format ["#(rgb,8,8,3)color(%1,%2,%3,%4)", PG_CurveColor#0, PG_CurveColor#1, PG_CurveColor#2, PG_CurveColor#3];

{
    if (_forEachIndex < _maxIndex) then
    {
        _ctrlMap drawLine
        [
            PG_InterpolatedPath # _forEachIndex,
            PG_InterpolatedPath # (_forEachIndex + 1),
            PG_CurveColor
        ];
    };
    _ctrlMap drawEllipse
    [
        PG_InterpolatedPath # _forEachIndex,
        2,
        2,
        0,
        PG_CurveColor,
        _colorPoints
    ];
} forEach PG_InterpolatedPath;
