with uiNamespace do
{
    params [["_center", [0, 0, 0]]];

    if (call PG_fnc_getSegmentCount == 0) then
    {
        private _anchorPoint1 = [_center vectorAdd [-50, 0, 0]] call PG_fnc_createAnchorPoint;
        private _controlPoint1 = [_center vectorAdd [-50 * 0.5, 50 * 0.5, 0]] call PG_fnc_createControlPoint;
        private _controlPoint2 = [_center vectorAdd [50 * 0.5, -50 * 0.5, 0]] call PG_fnc_createControlPoint;
        private _anchorPoint2 = [_center vectorAdd [50, 0, 0]] call PG_fnc_createAnchorPoint;
    }
    else
    {
        private _previousAnchor = [count PG_Points - 1] call PG_fnc_getPointEntityFromIndex;
        private _previousControlPoint = [count PG_Points - 2] call PG_fnc_getPointEntityFromIndex;

        private _newPos = _previousAnchor getPos [_previousAnchor distance2D _previousControlPoint, _previousControlPoint getDir _previousAnchor];

        private _controlPointPreviousAnchor = [_newPos] call PG_fnc_createControlPoint;

        // private _newControlPointPosition = _center getPos [(_center distance2D _newPos) * 0.5, _newPos getDir _center];
        // Calculate new position with fancy vector stuff
        private _newControlPointPosition = (_newPos vectorDiff _center vectorMultiply 0.5) vectorAdd _center;

        private _controlPoint1 = [_newControlPointPosition] call PG_fnc_createControlPoint;
        private _anchorPoint = [_center] call PG_fnc_createAnchorPoint;
    };
};
