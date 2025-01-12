#include "\a3\3den\ui\resincl.inc"

if (PG_InterpolatedPath isNotEqualTo []) then
{
    uiNamespace setVariable ["display3DENCopy_data", ["Interpolated Path", str PG_InterpolatedPath]];
    findDisplay IDD_DISPLAY3DEN createDisplay "display3denCopy";
};
