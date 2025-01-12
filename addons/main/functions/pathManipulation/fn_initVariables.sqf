with uiNamespace do
{
    // Necessary variables
    if (isNil "PG_LookUpTable") then
    {
        PG_LookUpTable = createHashMap; // Stores [entityID, index in PG_Points]
    };

    if (isNil "PG_Points") then
    {
        PG_Points = [];
    };

    if (isNil "PG_EquallySpacedPoints") then
    {
        PG_EquallySpacedPoints = [];
    };

    if (isNil "PG_ControlPointsMoveTogether") then
    {
        PG_ControlPointsMoveTogether = true;
    };

    if (isNil "PG_Points_Old") then
    {
        PG_Points_Old = [];
    };

    if (isNil "PG_DrawEvenlySpacedPoints_Handle") then
    {
        PG_DrawEvenlySpacedPoints_Handle = scriptNull;
    };
};
