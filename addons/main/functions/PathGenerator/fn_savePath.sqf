if (PG_Points isNotEqualTo []) then
{
    private _inputDisplay = findDisplay 313 createDisplay "Display3DENRename";

    // Ok Button
    (_inputDisplay displayCtrl 1) ctrlAddEventHandler ["ButtonClick",
    {
        params ["_ctrlButtonOk"];

        private _pathName = ctrlText (ctrlParent _ctrlButtonOk displayCtrl 101);

        if (_pathName != "") then
        {
            _pathName = format ["%1 - %2", [systemTime] call ENH_fnc_systemTimeFormatted, _pathName];

            private _storedPaths = profileNamespace getVariable ["PG_StoredPaths", createHashMap];
            _storedPaths set [_pathName, PG_Points];
            profileNamespace setVariable ["PG_StoredPaths", _storedPaths];
            saveProfileNamespace;
        };
    }];
};
