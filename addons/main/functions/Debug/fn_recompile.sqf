if !is3DEN exitWith {false};

allVariables missionNamespace apply
{
    if (_x select [0, 7] == "pg_fnc_") then
    {
        [_x] call BIS_fnc_recompile;
    };
};

["All PG functions were recompiled"] call BIS_fnc_3DENNotification;

true
