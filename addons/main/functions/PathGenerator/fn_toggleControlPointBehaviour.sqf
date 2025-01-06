params ["_ctrlMenuStrip", "_path"];

private _state = missionNamespace getVariable ["PG_ControlPointsMoveTogether", true];

missionNamespace setVariable ["PG_ControlPointsMoveTogether", !_state];