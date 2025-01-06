class Cfg3DEN
{
    class EventHandlers
    {
        class PathGenerator
        {
            Init = "_this call PG_fnc_3DENInit";
            OnEntityDragged = "_this call PG_fnc_movePoint";
        };
        class PathGenerator_Debug
        {
            OnMissionSave = "call PG_fnc_recompile";
        };
    };
};
