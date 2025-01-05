
#ifdef DEBUG_ENABLED_FULL
allowFunctionsRecompile = 1;
allowFunctionsLog = 1;
#endif

class CfgFunctions
{

	class PG
	{

		class 3DEN
		{

			class menuStrip { file = "functions\3DEN\fn_menuStrip.sqf"; };

		};

		class Debug
		{

			class recompile { file = "functions\Debug\fn_recompile.sqf"; };

		};

		class PathGenerator
		{

			class createAnchorPoint { file = "functions\PathGenerator\fn_createAnchorPoint.sqf"; };
			class createControlPoint { file = "functions\PathGenerator\fn_createControlPoint.sqf"; };
			class createSegment { file = "functions\PathGenerator\fn_createSegment.sqf"; };
			class drawConnections { file = "functions\PathGenerator\fn_drawConnections.sqf"; };
			class drawPath { file = "functions\PathGenerator\fn_drawPath.sqf"; };
			class getMouseToWorldPos { file = "functions\PathGenerator\fn_getMouseToWorldPos.sqf"; };
			class getPointEntityFromIndex { file = "functions\PathGenerator\fn_getPointEntityFromIndex.sqf"; };
			class getPointEntityIndex { file = "functions\PathGenerator\fn_getPointEntityIndex.sqf"; };
			class getPointsInSegment { file = "functions\PathGenerator\fn_getPointsInSegment.sqf"; };
			class getPointsLayer { file = "functions\PathGenerator\fn_getPointsLayer.sqf"; };
			class getSegmentCount { file = "functions\PathGenerator\fn_getSegmentCount.sqf"; };
			class handleDeletion { file = "functions\PathGenerator\fn_handleDeletion.sqf"; };
			class main { file = "functions\PathGenerator\fn_main.sqf"; };
			class movePoint { file = "functions\PathGenerator\fn_movePoint.sqf"; };
			class reset { file = "functions\PathGenerator\fn_reset.sqf"; };
			class updatePoint { file = "functions\PathGenerator\fn_updatePoint.sqf"; };

		};

	};

};
