params ["_ctrlMap"];

if (PG_Points isEqualTo []) exitWith {};

for "_index" from 0 to (count PG_Points - 1) do
{
    if (_index mod 3 == 0) then
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
            else // Someone anchor point in the middle, previous and following control points are present
            {
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index + 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
                _ctrlMap drawLine [PG_Points # _index, PG_Points # (_index - 1), PG_ConnectionLineColor, PG_ConnectionLineWidth];
            };
        };
    };
};