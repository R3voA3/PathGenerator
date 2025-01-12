with uiNamespace do
{
    params ["_index"];

    {
        if (_y == _index) exitWith
        {
            get3DENEntity _x;
        };
    } forEach PG_LookUpTable;
};
