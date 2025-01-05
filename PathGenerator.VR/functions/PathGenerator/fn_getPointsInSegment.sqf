params ["_i"];

[
    PG_Points select (_i * 3 + 0),
    PG_Points select (_i * 3 + 1),
    PG_Points select (_i * 3 + 2),
    PG_Points select (_i * 3 + 3)
];
