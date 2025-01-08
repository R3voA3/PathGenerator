#define RESOLUTION 5

private _segmentCount = call PG_fnc_getSegmentCount;

if (scriptDone PG_DrawEvenlySpacedPoints_Handle && {PG_Points_Old isNotEqualTo PG_Points}) then
{
    PG_DrawEvenlySpacedPoints_Handle = _segmentCount spawn
    {
        params ["_segmentCount"];

        PG_Points_Old = +PG_Points;

        if (_segmentCount > 0) then
        {
            params [["_spacing", 10]];

            // Clear previous points
            PG_EquallySpacedPoints = [];

            private _previousPoint = PG_Points # 0;
            PG_EquallySpacedPoints pushBack _previousPoint;

            private _t = 0;
            private _estimatedSegmentLength = 0;
            private _stepSize = 1;
            private _currentPoint = [0, 0, 0];
            private _distance = 0;
            private _overshotDistance = 0;
            private _newPoint = [0, 0, 0];

            for "_i" from 0 to (_segmentCount - 1) do
            {
                [_i] call PG_fnc_getPointsInSegment params ["_p0", "_p1", "_p2", "_p3"];

                _t = 0;

                // Estimate the length of the segment to calculate the step size. That way the resolution paramter can
                // control the accuracy
                _estimatedSegmentLength = (_p0 distance2D _p2) + 0.5 * ((_p0 distance2D _p1) + (_p1 distance2D _p3) + (_p2 distance2D _p3));
                _stepSize = 1 / (_estimatedSegmentLength * RESOLUTION); // Make sure 0 doesn't crash the game

                while {_t <= 1} do
                {
                    _currentPoint = _t bezierInterpolation [_p0, _p1, _p2, _p3];
                    _distance = _currentPoint distance2D _previousPoint;

                    if (_currentPoint distance2D _previousPoint >= _spacing) then
                    {
                        _overshotDistance = _distance - _spacing;

                        // Calculate the correct point
                        _newPoint = _currentPoint vectorAdd (vectorNormalized (_previousPoint vectorDiff _currentPoint) vectorMultiply _overshotDistance);

                        PG_EquallySpacedPoints pushBackUnique _newPoint;
                        _previousPoint = _newPoint;
                    };
                    _t = _t + _stepSize;
                };
            };
        };
    };
};

nil
