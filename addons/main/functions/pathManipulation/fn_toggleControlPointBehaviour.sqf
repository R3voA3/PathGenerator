params ["_ctrlMenuStrip", "_path"];

private _state = missionNamespace getVariable ["PG_ControlPointsMoveTogether", true];

missionNamespace setVariable ["PG_ControlPointsMoveTogether", !_state];

[
    [
        "Control Points will now move together",
        "Control Points will now move independently"
    ] select _state
] call BIS_fnc_3DENNotification;
