0 spawn
{
    with uiNamespace do
    {
        // Huge delay is needed because for some unknown reason
        // we cannot manipulate entities immediately
        sleep 2;

        if (PG_Points isNotEqualTo []) then
        {
            call PG_fnc_removePathLayer;
            [+PG_Points] call PG_fnc_createPathFromArray;
        };
    };
};
