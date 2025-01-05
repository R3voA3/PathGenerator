private _ctrlMap = findDisplay 313 displayctrl 51;

if (get3DENActionState "togglemap" > 0) exitWith
{
    (_ctrlMap ctrlMapScreenToWorld getMousePosition) + [0];
};
[0, 0, 0];
