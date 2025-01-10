class Cfg3DEN
{
    class Attributes
    {
        class Title;
        class Slider: Title
        {
            class Controls
            {
                class Title;
                class Edit;
                class Value;
            };
        };
        class PG_SliderPointZeroOneToOne: Slider
        {
            attributeLoad = "params ['_ctrlGroup']; [_ctrlGroup controlsGroupCtrl 100, _ctrlGroup controlsGroupCtrl 101, '', _value] call BIS_fnc_initSliderValue";
            onLoad = "params ['_ctrlGroup']; [_ctrlGroup controlsGroupCtrl 100, _ctrlGroup controlsGroupCtrl 101, ''] call BIS_fnc_initSliderValue";
            class Controls: Controls
            {
                class Title: Title {};
                class Edit: Edit {};
                class Value: Value
                {
                    lineSize = 0.01;
                    sliderPosition = 0.5;
                    sliderRange[] = {0.01, 1};
                    sliderStep = 0.01;
                };
            };
        };
        class PG_SliderOneToFifty: PG_SliderPointZeroOneToOne
        {
            class Controls: Controls
            {
                class Title: Title {};
                class Edit: Edit {};
                class Value: Value
                {
                    lineSize = 1;
                    sliderPosition = 25;
                    sliderRange[] = {1, 50};
                    sliderStep = 1;
                };
            };
        };
    };
    class EventHandlers
    {
        class PathGenerator
        {
            Init = "call PG_fnc_3DENInit";
        };
        class PathGenerator_Debug
        {
            OnMissionSave = "call PG_fnc_recompile";
        };
    };
    class Mission
    {
        class Preferences
        {
            class AttributeCategories
            {
                class PG_PathGenerator
                {
                    displayName = "Path Generator";
                    class Attributes
                    {
                        class PG_ConnectionLineWidth
                        {
                            displayName = "Connection Line Width";
                            property = "PG_ConnectionLineWidth";
                            control = "PG_SliderOneToFifty";
                            expression = "profileNamespace setVariable ['PG_ConnectionLineWidth', _value]";
                            defaultValue = "profileNamespace getVariable ['PG_ConnectionLineWidth', 10]";
                        };
                        class PG_BezierResolution
                        {
                            displayName = "Bezier Curve Resolution";
                            property = "PG_BezierResolution";
                            control = "PG_SliderPointZeroOneToOne";
                            expression = "profileNamespace setVariable ['PG_BezierResolution', _value]";
                            defaultValue = "profileNamespace getVariable ['PG_BezierResolution', 0.03]";
                        };
                        class PG_ConnectionLineColor
                        {
                            displayName = "Connection Line Color";
                            property = "PG_ConnectionLineColor";
                            control = "MarkerColor";
                            expression = "profileNamespace setVariable ['PG_ConnectionLineColorString', _value];\
                            profileNamespace setVariable ['PG_ConnectionLineColor', [getArray (configFile >> 'CfgMarkerColors' >> _value >> 'color')] call BIS_fnc_colorConfigToRGBA];";
                            defaultValue = "profileNamespace getVariable ['PG_ConnectionLineColorString', 'ColorBlue']";
                        };
                        class PG_CurveColor
                        {
                            displayName = "Curve Color";
                            property = "PG_CurveColor";
                            control = "MarkerColor";
                            expression = "profileNamespace setVariable ['PG_CurveColorString', _value];\
                            profileNamespace setVariable ['PG_CurveColor', [getArray (configFile >> 'CfgMarkerColors' >> _value >> 'color')] call BIS_fnc_colorConfigToRGBA];";
                            defaultValue = "profileNamespace getVariable ['PG_CurveColorString', 'ColorBlack']";
                        };
                    };
                };
            };
        };
    };
};
