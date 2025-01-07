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
private _maxIndex = count PG_InterpolatedPath - 2;

{
    if (_forEachIndex < _maxIndex) then
    {
        (_this select 0) drawLine
        [
            PG_InterpolatedPath # _forEachIndex,
            PG_InterpolatedPath # (_forEachIndex + 1),
            PG_CurveColor
        ];
    };
} forEach PG_InterpolatedPath;
