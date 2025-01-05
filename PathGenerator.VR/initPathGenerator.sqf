PG_fnc_drawPath =
{
    private _interpolatedPath = [];
    if (call PG_fnc_getSegmentCount > 0) then
    {
        for "_i" from 0 to (call PG_fnc_getSegmentCount - 1) do
        {
            private _points = _i call PG_fnc_getPointsInSegment;

            for "_progress" from 0 to 1 step 0.03 do
            {
                _interpolatedPath pushback (_progress bezierInterpolation
                [
                    _points select 0,
                    _points select 1,
                    _points select 2,
                    _points select 3
                ]);
            };
        };
    };
    PG_Poly_Marker setMarkerPolyline flatten (_interpolatedPath apply {[_x#0, _x#1]});
};

PG_fnc_getMouseToWorldPos =
{
    private _ctrlMap = findDisplay 313 displayctrl 51;

    if (get3DENActionState "togglemap" > 0) exitWith
    {
        (_ctrlMap ctrlMapScreenToWorld getMousePosition) + [0];
    };
    [0, 0, 0];
};

PG_fnc_createSegment =
{
    private _center = call PG_fnc_getMouseToWorldPos;
    private _segmentCount = call PG_fnc_getSegmentCount;

    if (call PG_fnc_getSegmentCount == 0) then
    {
        private _anchorPoint1 = [_center vectorAdd [-50, 0, 0]] call PG_fnc_createAnchorPoint;
        private _controlPoint1 = [_center vectorAdd [-50 * 0.5, 50 * 0.5, 0]] call PG_fnc_createControlPoint;
        private _controlPoint2 = [_center vectorAdd [50 * 0.5, -50 * 0.5, 0]] call PG_fnc_createControlPoint;
        private _anchorPoint2 = [_center vectorAdd [50, 0, 0]] call PG_fnc_createAnchorPoint;

        add3DENConnection ["Sync", [_controlPoint1], _anchorPoint1];
        add3DENConnection ["Sync", [_controlPoint2], _anchorPoint2];
    }
    else
    {
        private _previousAnchor = [count PG_Points - 1] call PG_fnc_getPointEntityFromIndex;
        private _previousControlPoint = [count PG_Points - 2] call PG_fnc_getPointEntityFromIndex;

        private _newPos = _previousAnchor getPos [_previousAnchor distance _previousControlPoint, _previousControlPoint getDir _previousAnchor];

        private _controlPointPreviousAnchor = [_newPos] call PG_fnc_createControlPoint;
        private _controlPoint1 = [_center vectorAdd [100 * 0.5, -50 * 0.5, 0]] call PG_fnc_createControlPoint;
        private _anchorPoint = [_center] call PG_fnc_createAnchorPoint;

        add3DENConnection ["Sync", [_controlPointPreviousAnchor], _previousAnchor];
        add3DENConnection ["Sync", [_controlPoint1], _anchorPoint];
    };
};

PG_fnc_getSegmentCount =
{
    if (PG_Points isEqualTo []) exitWith {0};

    _count = (count PG_Points - 4) / 3 + 1; // First segment has 4 points, following segments only 3
    _count;
};

PG_fnc_createAnchorPoint =
{
    params ["_position", ["_isNew", true], ["_oldIndex", -1]];

    private _anchorPoint = create3DENEntity ["Logic", "SideOPFOR_F", _position];
    _anchorPoint set3DENAttribute ["name", str count PG_Points];
    _anchorPoint set3DENLayer (call PG_fnc_getPointsLayer);

    if _isNew then
    {
        PG_Points append [getPosATL _anchorPoint];
    };

    // If we create entities from existing path then we reuse the old index
    private _index = if (_oldIndex > -1) then {_oldIndex} else {count PG_Points - 1};

    PG_LookUpTable set [get3DENEntityID _anchorPoint, _index];

    _anchorPoint
};

PG_fnc_createControlPoint =
{
    params ["_position", ["_isNew", true], ["_oldIndex", -1]];

    private _controlPoint = create3DENEntity ["Logic", "Logic", _position];
    _controlPoint set3DENAttribute ["name", str count PG_Points];
    _controlPoint set3DENLayer (call PG_fnc_getPointsLayer);

    if _isNew then
    {
        PG_Points append [getPosATL _controlPoint];
    };

        // If we create entities from existing path then we reuse the old index
    private _index = if (_oldIndex > -1) then {_oldIndex} else {count PG_Points - 1};

    PG_LookUpTable set [get3DENEntityID _controlPoint, _index];

    _controlPoint
};

PG_fnc_getPointsLayer =
{
    #define LAYER "PG: Points"
    private _layerID = -1;

    {
        if (((_x get3DENAttribute "name") select 0) == LAYER) exitWith
        {
            _layerID = get3DENEntityID _x;
        };
    } forEach (all3DENEntities select 6);

    if (_layerID == -1) then
    {
        _layerID = -1 add3DENLayer LAYER;
    };

    _layerID
};

PG_fnc_getPointsInSegment =
{
    params ["_i"];

    [
        PG_Points select (_i * 3 + 0),
        PG_Points select (_i * 3 + 1),
        PG_Points select (_i * 3 + 2),
        PG_Points select (_i * 3 + 3)
    ];
};

PG_fnc_movePoint =
{
    params ["_pointEntity"];

    private _index = [get3DENEntityID _pointEntity] call PG_fnc_getPointEntityIndex;

    // Dragging an entity not related to the path
    if (_index == -1) exitWith {};

    private _currentPosition = PG_Points select _index;
    private _newPosition = _pointEntity get3DENAttribute "position" select 0;
    private _posDelta = (_currentPosition vectorDiff _newPosition) vectorMultiply -1; // Negate numbers otherwise we rotate around the center of both points

    if (_posDelta isEqualTo [0, 0, 0]) exitWith {};

    PG_Points set [_index, _newPosition];

    if (_index % 3 == 0) then // Anchor point
    {
        if (_index == 0) then // First anchor point in path, no previous control point
        {
            private _controlPoint = [_index + 1] call PG_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = PG_Points select (_index + 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            PG_Points set [_index + 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
        if (_index == (count PG_Points - 1)) then // Last anchor point. Only a previous control point
        {
            private _controlPoint = [_index - 1] call PG_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = PG_Points select (_index - 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            PG_Points set [_index - 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
        if (_index > 0 && _index < (count PG_Points - 1)) then // Two anchor points (_index - 1, _index + 1)
        {
            private _controlPoint = [_index + 1] call PG_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = PG_Points select (_index + 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            PG_Points set [_index + 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];

            private _controlPoint = [_index - 1] call PG_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = PG_Points select (_index - 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            PG_Points set [_index - 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
    }
    else // Control points
    {

    };
};

PG_fnc_getPointEntityIndex =
{
    params ["_3DENID"];
    PG_LookUpTable getOrDefault [_3DENID, -1];
};

PG_fnc_updatePoint =
{
    params ["_index", "_position"];
    PG_Points set [_index, _position];
};

// This is slow and should become a hashmap
// We loop through the lookup table to find the entity ID by its index
PG_fnc_getPointEntityFromIndex =
{
    params ["_index"];

    {
        if (_y == _index) exitWith
        {
            get3DENEntity _x;
        };
    } forEach PG_LookUpTable;
};

PG_fnc_handleDeletion =
{
    params ["_pointEntity"];

    private _index = [_pointEntity] call PG_fnc_getPointEntityIndex;

    if (_index mod 3 == 0) then
    {

    };


    // When a control point is deleted, it's anchor and all its other control points get deleted as well
    // Update PG_Points
};

/* PG_fnc_createPointsFromPath =
{
    params ["_path"];

    {
        // Anchor point
        if (_forEachIndex mod 3 == 0) then
        {
            [_x, false, _forEachIndex] call PG_fnc_createAnchorPoint;
        }
        else // Control Point
        {
            [_x, false, _forEachIndex] call PG_fnc_createControlPoint;
        };
    } forEach _path;
}; */

//################################################################*##################################################################
//LOGIC#############################################################################################################################
//##################################################################################################################################

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
