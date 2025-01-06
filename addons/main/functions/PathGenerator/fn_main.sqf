private _display3DEN = findDisplay 313;

if (get3DENActionState "togglemap" == 0) then
{
    do3DENAction "toggleMap";
};

// Clear layer if it exists
delete3DENEntities (get3DENLayerEntities (call PG_fnc_getPointsLayer));

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

/* if (isNil "PG_ShiftToggled") then
{
    PG_ShiftToggled = false;
};
 */
if (_display3DEN getVariable ["PG_KeyDown_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "PG_KeyDown_EH_ID",
        _display3DEN displayAddEventHandler ["KeyDown",
        {
            params ["", "_key", "_shift"];

            if (_key == 57 && _shift) then
            {
                call PG_fnc_createSegment;
            };
        }]
    ];
};

if (_display3DEN getVariable ["PG_3DEN_Drag_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "PG_3DEN_Drag_EH_ID",
        add3DENEventHandler ["OnEntityDragged",
        {
            _this call PG_fnc_movePoint;
        }]
    ];
};

private _ctrlMap = _display3DEN displayCtrl 51;

if (_ctrlMap getVariable ["PG_Draw_EH_ID", -1] == -1) then
{
    _ctrlMap setVariable
    [
        "PG_Draw_EH_ID",
        _ctrlMap ctrlAddEventHandler ["Draw",
        {
            call PG_fnc_drawPath;
            _this call PG_fnc_drawConnections;
        }]
    ];
};
