params [["_countPoints", 10], ["_maxDistance", 500]];

call PG_fnc_reset;

private _points = [];
private _center = [worldSize * 0.5, worldSize * 0.5];

for "_index" from 0 to (_countPoints - 1) do
{
    private _randomPos = [_center, [_maxDistance, _maxDistance, 0, false]] call BIS_fnc_randomPosTrigger;

    [_randomPos] call PG_fnc_createSegment;
};
