// Necessary variables
if (isNil "PG_LookUpTable") then
{
    PG_LookUpTable = createHashMap; // Stores [entityID, index in PG_Points]
};

if (isNil "PG_Points") then
{
    PG_Points = [];
};

if (isNil "PG_ControlPointsMoveTogether") then
{
    PG_ControlPointsMoveTogether = true;
};

// Settings
if (isNil "PG_ConnectionLineWidth") then
{
    PG_ConnectionLineWidth = 10;
};

if (isNil "PG_ConnectionLineColor") then
{
    PG_ConnectionLineColor = [1, 0, 0, 1];
};

if (isNil "PG_CurveColor") then
{
    PG_CurveColor = [0, 0, 1, 1];
};

if (isNil "PG_BezierResolution") then
{
    PG_BezierResolution = 0.03;
};
