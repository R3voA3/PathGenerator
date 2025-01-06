allowFunctionsRecompile = 1;
allowFunctionsLog = 1;

class CfgFunctions
{
    class PG
    {
        class 3DEN
        {
            class 3DENInit { file = "x\pg\addons\main\functions\3DEN\fn_3DENInit.sqf"; };
        };
        class Debug
        {
            class recompile { file = "x\pg\addons\main\functions\Debug\fn_recompile.sqf"; };
        };
        class PathGenerator
        {
            class createAnchorPoint { file = "x\pg\addons\main\functions\PathGenerator\fn_createAnchorPoint.sqf"; };
            class createControlPoint { file = "x\pg\addons\main\functions\PathGenerator\fn_createControlPoint.sqf"; };
            class createSegment { file = "x\pg\addons\main\functions\PathGenerator\fn_createSegment.sqf"; };
            class drawConnections { file = "x\pg\addons\main\functions\PathGenerator\fn_drawConnections.sqf"; };
            class drawPath { file = "x\pg\addons\main\functions\PathGenerator\fn_drawPath.sqf"; };
            class getMouseToWorldPos { file = "x\pg\addons\main\functions\PathGenerator\fn_getMouseToWorldPos.sqf"; };
            class getPointEntityFromIndex { file = "x\pg\addons\main\functions\PathGenerator\fn_getPointEntityFromIndex.sqf"; };
            class getPointEntityIndex { file = "x\pg\addons\main\functions\PathGenerator\fn_getPointEntityIndex.sqf"; };
            class getPointsInSegment { file = "x\pg\addons\main\functions\PathGenerator\fn_getPointsInSegment.sqf"; };
            class getPointsLayer { file = "x\pg\addons\main\functions\PathGenerator\fn_getPointsLayer.sqf"; };
            class getSegmentCount { file = "x\pg\addons\main\functions\PathGenerator\fn_getSegmentCount.sqf"; };
            class handleDeletion { file = "x\pg\addons\main\functions\PathGenerator\fn_handleDeletion.sqf"; };
            class initVariables { file = "x\pg\addons\main\functions\PathGenerator\fn_initVariables.sqf"; };
            class isAnchorPoint { file = "x\pg\addons\main\functions\PathGenerator\fn_isAnchorPoint.sqf"; };
            class main { file = "x\pg\addons\main\functions\PathGenerator\fn_main.sqf"; };
            class movePoint { file = "x\pg\addons\main\functions\PathGenerator\fn_movePoint.sqf"; };
            class reset { file = "x\pg\addons\main\functions\PathGenerator\fn_reset.sqf"; };
            class toggleControlPointBehaviour { file = "x\pg\addons\main\functions\PathGenerator\fn_toggleControlPointBehaviour.sqf"; };
            class updatePoint { file = "x\pg\addons\main\functions\PathGenerator\fn_updatePoint.sqf"; };
            class savePath { file = "x\pg\addons\main\functions\PathGenerator\fn_savePath.sqf"; };
        };
    };
};
