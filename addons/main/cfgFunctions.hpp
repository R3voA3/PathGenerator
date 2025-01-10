class CfgFunctions
{
    class PathGenerator
    {
        tag = "PG";
        class 3DEN
        {
            file = "x\pg\addons\main\functions\3DEN";
            class 3DENInit {headerType = -1;};
            class createEntitiesOnPath {headerType = -1;};
        };
        class Debug
        {
            file = "x\pg\addons\main\functions\debug";
            class createRandomPath {headerType = -1;};
            class recompile {headerType = -1;};
        };
        class PathManipulation
        {
            file = "x\pg\addons\main\functions\pathManipulation";
            class addEventHandlers {headerType = -1;};
            class createAnchorPoint {headerType = -1;};
            class createControlPoint {headerType = -1;};
            class createPathFromArray {headerType = -1;};
            class createSegment {headerType = -1;};
            class draw {headerType = -1;};
            class getEvenlySpacedPoints {headerType = -1;};
            class getMouseToWorldPos {headerType = -1;};
            class getPointEntityFromIndex {headerType = -1;};
            class getPointEntityIndex {headerType = -1;};
            class getPointsInSegment {headerType = -1;};
            class getPointsLayer {headerType = -1;};
            class getSegmentCount {headerType = -1;};
            class handleDeletion {headerType = -1;};
            class initVariables {headerType = -1;};
            class isAnchorPoint {headerType = -1;};
            class loadPath {headerType = -1;};
            class main {headerType = -1;};
            class movePoint {headerType = -1;};
            class reset {headerType = -1;};
            class savePath {headerType = -1;};
            class toggleControlPointBehaviour {headerType = -1;};
            class updatePoint {headerType = -1;};
        };
    };
};
