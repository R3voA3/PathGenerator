private _display3DEN = findDisplay 313;

if (get3DENActionState "togglemap" == 0) then
{
    do3DENAction "toggleMap";
};

if (isNil "PG_LookUpTable") then
{
    PG_LookUpTable = createHashMap; // Stores [entityID, index in PG_Points]
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
    call PG_fnc_drawPath;
};

if (_display3DEN getVariable ["PG_KeyDown_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "PG_KeyDown_EH_ID",
        _display3DEN displayAddEventHandler ["KeyDown",
        {
            params ["_display3DEN", "_key", "_shift"];

            if (_key == 57 && _shift) then
            {
                call PG_fnc_createSegment;
                call PG_fnc_drawPath;
            };
        }]
    ];
};

if (_display3DEN getVariable ["PG_3DEN_Removed_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "PG_3DEN_Removed_EH_ID",
        add3DENEventHandler ["OnEditableEntityRemoved",
        {
            params ["_entity"];
            call PG_fnc_drawPath;
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
            call PG_fnc_drawPath;
        }]
    ];
};
