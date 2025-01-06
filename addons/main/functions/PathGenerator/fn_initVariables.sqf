if (isNil "PG_LookUpTable") then
{
    PG_LookUpTable = createHashMap; // Stores [entityID, index in PG_Points]
};

if (isNil "PG_ConnectionLineWidth") then
{
    PG_ConnectionLineWidth = 20;
};

if (isNil "PG_ConnectionLineColor") then
{
    PG_ConnectionLineColor = [1, 0, 0, 1];
};

if (isNil "PG_Poly_Marker") then
{
    PG_Poly_Marker = createMarker [hashValue systemTimeUTC, [0, 0, 0]];
    PG_Poly_Marker setMarkerShape "polyline";
};

if (isNil "PG_Points") then
{
    PG_Points = [];
    call PG_fnc_createSegment;
};

if (isNil "PG_ControlPointsMoveTogether") then
{
    PG_ControlPointsMoveTogether = true;
};