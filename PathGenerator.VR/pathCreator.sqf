ENH_fnc_drawPath =
{
    private _interpolatedPath = [];
    if (call ENH_fnc_getSegmentCount > 0) then
    {
        for "_i" from 0 to (call ENH_fnc_getSegmentCount - 1) do
        {
            private _points = _i call ENH_fnc_getPointsInSegment;

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
    ENH_Poly_Marker setMarkerPolyline flatten (_interpolatedPath apply {[_x#0, _x#1]});
};

ENH_fnc_getMouseToWorldPos =
{
    private _ctrlMap = findDisplay 313 displayctrl 51;

    if (get3DENActionState "togglemap" > 0) exitWith
    {
        (_ctrlMap ctrlMapScreenToWorld getMousePosition) + [0];
    };
    [0, 0, 0];
};

ENH_fnc_createSegment =
{
    private _center = call ENH_fnc_getMouseToWorldPos;
    private _segmentCount = call ENH_fnc_getSegmentCount;

    if (call ENH_fnc_getSegmentCount == 0) then
    {
        private _anchorPoint1 = [_center vectorAdd [-50, 0, 0]] call ENH_fnc_createAnchorPoint;
        private _controlPoint1 = [_center vectorAdd [-50 * 0.5, 50 * 0.5, 0]] call ENH_fnc_createControlPoint;
        private _controlPoint2 = [_center vectorAdd [50 * 0.5, -50 * 0.5, 0]] call ENH_fnc_createControlPoint;
        private _anchorPoint2 = [_center vectorAdd [50, 0, 0]] call ENH_fnc_createAnchorPoint;

        add3DENConnection ["Sync", [_controlPoint1], _anchorPoint1];
        add3DENConnection ["Sync", [_controlPoint2], _anchorPoint2];
    }
    else
    {
        private _previousAnchor = [count ENH_Points - 1] call ENH_fnc_getPointEntityFromIndex;
        private _previousControlPoint = [count ENH_Points - 2] call ENH_fnc_getPointEntityFromIndex;

        private _newPos = _previousAnchor getPos [_previousAnchor distance _previousControlPoint, _previousControlPoint getDir _previousAnchor];

        private _controlPointPreviousAnchor = [_newPos] call ENH_fnc_createControlPoint;
        private _controlPoint1 = [_center vectorAdd [100 * 0.5, -50 * 0.5, 0]] call ENH_fnc_createControlPoint;
        private _anchorPoint = [_center] call ENH_fnc_createAnchorPoint;

        add3DENConnection ["Sync", [_controlPointPreviousAnchor], _previousAnchor];
        add3DENConnection ["Sync", [_controlPoint1], _anchorPoint];
    };
};

ENH_fnc_getSegmentCount =
{
    if (ENH_Points isEqualTo []) exitWith {0};

    _count = (count ENH_Points - 4) / 3 + 1; // First segment has 4 points, following segments only 3
    _count;
};

ENH_fnc_createAnchorPoint =
{
    params ["_position", ["_isNew", true], ["_oldIndex", -1]];

    private _anchorPoint = create3DENEntity ["Logic", "SideOPFOR_F", _position];
    _anchorPoint set3DENAttribute ["name", str count ENH_Points];

    if _isNew then
    {
        ENH_Points append [getPosATL _anchorPoint];
    };

    // If we create entities from existing path then we reuse the old index
    private _index = if (_oldIndex > -1) then {_oldIndex} else {count ENH_Points - 1};

    ENH_LookUpTable set [get3DENEntityID _anchorPoint, _index];

    _anchorPoint
};

ENH_fnc_createControlPoint =
{
    params ["_position", ["_isNew", true], ["_oldIndex", -1]];

    private _controlPoint = create3DENEntity ["Logic", "Logic", _position];
    _controlPoint set3DENAttribute ["name", str count ENH_Points];

    if _isNew then
    {
        ENH_Points append [getPosATL _controlPoint];
    };

        // If we create entities from existing path then we reuse the old index
    private _index = if (_oldIndex > -1) then {_oldIndex} else {count ENH_Points - 1};

    ENH_LookUpTable set [get3DENEntityID _controlPoint, _index];

    _controlPoint
};

ENH_fnc_getPointsInSegment =
{
    params ["_i"];

    [
        ENH_Points select (_i * 3 + 0),
        ENH_Points select (_i * 3 + 1),
        ENH_Points select (_i * 3 + 2),
        ENH_Points select (_i * 3 + 3)
    ];
};

ENH_fnc_movePoint =
{
    params ["_pointEntity"];

    private _index = [get3DENEntityID _pointEntity] call ENH_fnc_getPointEntityIndex;

    // Dragging an entity not related to the path
    if (_index == -1) exitWith {};

    private _currentPosition = ENH_Points select _index;
    private _newPosition = _pointEntity get3DENAttribute "position" select 0;
    private _posDelta = (_currentPosition vectorDiff _newPosition) vectorMultiply -1; // Negate numbers otherwise we rotate around the center of both points

    if (_posDelta isEqualTo [0, 0, 0]) exitWith {};

    ENH_Points set [_index, _newPosition];

    if (_index % 3 == 0) then // Anchor point
    {
        if (_index == 0) then // First anchor point in path, no previous control point
        {
            private _controlPoint = [_index + 1] call ENH_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = ENH_Points select (_index + 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            ENH_Points set [_index + 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
        if (_index == (count ENH_Points - 1)) then // Last anchor point. Only a previous control point
        {
            private _controlPoint = [_index - 1] call ENH_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = ENH_Points select (_index - 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            ENH_Points set [_index - 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
        if (_index > 0 && _index < (count ENH_Points - 1)) then // Two anchor points (_index - 1, _index + 1)
        {
            private _controlPoint = [_index + 1] call ENH_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = ENH_Points select (_index + 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            ENH_Points set [_index + 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];

            private _controlPoint = [_index - 1] call ENH_fnc_getPointEntityFromIndex;
            private _OldControlPointPosition = ENH_Points select (_index - 1);
            private _newControlPointPosition = _OldControlPointPosition vectorAdd _posDelta;

            ENH_Points set [_index - 1, _newControlPointPosition];
            _controlPoint set3DENAttribute ["position", _newControlPointPosition];
        };
    }
    else // Control points
    {

    };
};

ENH_fnc_getPointEntityIndex =
{
    params ["_3DENID"];
    ENH_LookUpTable getOrDefault [_3DENID, -1];
};

ENH_fnc_updatePoint =
{
    params ["_index", "_position"];
    ENH_Points set [_index, _position];
};

// This is slow and should become a hashmap
// We loop through the lookup table to find the entity ID by its index
ENH_fnc_getPointEntityFromIndex =
{
    params ["_index"];

    {
        if (_y == _index) exitWith
        {
            get3DENEntity _x;
        };
    } forEach ENH_LookUpTable;
};

ENH_fnc_handleDeletion =
{
    params ["_pointEntity"];

    private _index = [_pointEntity] call ENH_fnc_getPointEntityIndex;

    if (_index mod 3 == 0) then
    {

    };


    // When a control point is deleted, it's anchor and all its other control points get deleted as well
    // Update ENH_Points
};

/* ENH_fnc_createPointsFromPath =
{
    params ["_path"];

    {
        // Anchor point
        if (_forEachIndex mod 3 == 0) then
        {
            [_x, false, _forEachIndex] call ENH_fnc_createAnchorPoint;
        }
        else // Control Point
        {
            [_x, false, _forEachIndex] call ENH_fnc_createControlPoint;
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

if (isNil "ENH_LookUpTable") then
{
    ENH_LookUpTable = createHashMap; // Stores [entityID, index in ENH_Points]
};

if (isNil "ENH_Poly_Marker") then
{
    ENH_Poly_Marker = createMarker [hashValue systemTimeUTC, [0, 0, 0]];
    ENH_Poly_Marker setMarkerShape "polyline";
};

if (isNil "ENH_Points") then
{
    ENH_Points = [];
    call ENH_fnc_createSegment;
    call ENH_fnc_drawPath;
};

if (_display3DEN getVariable ["ENH_KeyDown_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "ENH_KeyDown_EH_ID",
        _display3DEN displayAddEventHandler ["KeyDown",
        {
            params ["_display3DEN", "_key", "_shift"];

            if (_key == 57 && _shift) then
            {
                call ENH_fnc_createSegment;
                call ENH_fnc_drawPath;
            };
        }]
    ];
};

if (_display3DEN getVariable ["ENH_3DEN_Removed_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "ENH_3DEN_Removed_EH_ID",
        add3DENEventHandler ["OnEditableEntityRemoved",
        {
            params ["_entity"];
            call ENH_fnc_drawPath;
        }]
    ];
};

if (_display3DEN getVariable ["ENH_3DEN_Drag_EH_ID", -1] == -1) then
{
    _display3DEN setVariable
    [
        "ENH_3DEN_Drag_EH_ID",
        add3DENEventHandler ["OnEntityDragged",
        {
            _this call ENH_fnc_movePoint;
            call ENH_fnc_drawPath;
        }]
    ];
};
