disableSerialization;

private _savedPaths = profileNamespace getVariable ["PG_StoredPaths", createHashMap];

if (_savedPaths isNotEqualTo []) then
{
    private _display = findDisplay 313 createDisplay "RscDisplayEmpty";

    private _edit = _display ctrlCreate ["RscEdit", 645];
    _edit ctrlSetPosition [0, 0, 1, 0.04];
    _edit ctrlSetBackgroundColor [0, 0, 0, 1];
    _edit ctrlCommit 0;

    private _tv = _display ctrlCreate ["RscTreeSearch", -1];
    _tv ctrlSetFont "EtelkaMonospacePro";
    _tv ctrlSetFontHeight 0.03;
    _tv ctrlSetPosition [0, 0.06, 1, 0.94];
    _tv ctrlSetBackgroundColor [0, 0, 0, 1];
    _tv ctrlCommit 0;

    {
        _tv tvAdd [[], _x];
    } forEach _savedPaths;

    _tv ctrlAddEventHandler ["TreeDblClick",
    {
        params ["_ctrlTV", "_path"];

        private _points = profileNamespace getVariable ["PG_StoredPaths", createHashMap] get (_ctrlTV tvText _path);

        if (_points isNotEqualTo []) then
        {
            call PG_fnc_reset;
            [_points] call PG_fnc_createPathFromArray;
        };
    }];
};
