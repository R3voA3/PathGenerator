private _interpolatedPath = [];
if (call PG_fnc_getSegmentCount > 0) then
{
    for "_i" from 0 to (call PG_fnc_getSegmentCount - 1) do
    {
        private _points = _i call PG_fnc_getPointsInSegment;

        for "_progress" from 0 to 1 step 0.03 do
        {
            _interpolatedPath pushback (_progress bezierInterpolation
            [
                _points select 0,
                _points select 1,
                _points select 2,
                _points select 3
            ]);
        };
    };
};
PG_Poly_Marker setMarkerPolyline flatten (_interpolatedPath apply {[_x#0, _x#1]});
