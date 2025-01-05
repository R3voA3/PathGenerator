params ["_ctrlMap"];

if (PG_Points isEqualTo []) exitWith {};

for "_index" from 0 to (count PG_Points - 1) do
{
    if (_index mod 3 == 0) then
    {
        if (_index == 0) then // First anchor point, no previous control point
        {
            _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index + 1), [1, 0, 0, 1], 2];
        }
        else
        {
            if (_index == (count PG_Points - 1)) then // Last anchor point, no following control point
            {
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index - 1), [1, 0, 0, 1], 2];
            }
            else // Someone anchor point in the middle, previous and following control points are present
            {
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index + 1), [1, 0, 0, 1], 2];
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index - 1), [1, 0, 0, 1], 2];
            };
        };
    };
};