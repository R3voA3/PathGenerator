params ["_pointEntity"];

_pointEntity addEventHandler ["AttributesChanged3DEN",
{
    params ["_pointEntity"];
    _pointEntity call PG_fnc_movePoint
}];

_pointEntity addEventHandler ["Dragged3DEN",
{
    params ["_pointEntity"];
    _pointEntity call PG_fnc_movePoint
}];

_pointEntity addEventHandler ["RegisteredToWorld3DEN",
{
    params ["_pointEntity"];
    systemChat "Re-Created";
}];

_pointEntity addEventHandler ["UnregisteredFromWorld3DEN",
{
    params ["_pointEntity"];
    systemChat "Deleted";
}];
