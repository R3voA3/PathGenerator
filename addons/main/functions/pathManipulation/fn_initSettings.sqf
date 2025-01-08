// https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#creating-a-setting

[
    "PG_ConnectionLineWidth",
    "SLIDER",
    "Connection Line Width",
    "Path Generator",
    [1, 30, profileNamespace getVariable ["PG_ConnectionLineWidth", 10], 0],
    nil,
    {
        params ["_value"];
        PG_ConnectionLineWidth = _value;
        profileNamespace setVariable ["PG_ConnectionLineWidth", _value];
    }
] call CBA_fnc_addSetting;

[
    "PG_ConnectionLineColor",
    "COLOR",
    "Connection Line Color",
    "Path Generator",
    profileNamespace getVariable ["PG_ConnectionLineColor", [1, 0, 0, 1]],
    nil,
    {
        params ["_value"];
        PG_ConnectionLineColor = _value;
        profileNamespace setVariable ["PG_ConnectionLineColor", _value];
    }
] call CBA_fnc_addSetting;

[
    "PG_CurveColor",
    "COLOR",
    "Curve Color",
    "Path Generator",
    profileNamespace getVariable ["PG_CurveColor", [0, 0, 1, 1]],
    nil,
    {
        params ["_value"];
        PG_CurveColor = _value;
        profileNamespace setVariable ["PG_CurveColor", _value];
    }
] call CBA_fnc_addSetting;

[
    "PG_BezierResolution",
    "SLIDER",
    "Bezier Curve Resolution",
    "Path Generator",
    [0.01, 1, profileNamespace getVariable ["PG_BezierResolution", 0.03], 3],
    nil,
    {
        params ["_value"];
        PG_BezierResolution = _value;
        profileNamespace setVariable ["PG_BezierResolution", _value];
    }
] call CBA_fnc_addSetting;
