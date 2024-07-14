page 50003 "SDH Rest No Auth Subform"
{
    ApplicationArea = All;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "SDH Rest No Auth Line";

    layout
    {
        area(Content)
        {
            repeater(ParametersLines)
            {
                Caption = 'Parameters and Values';
                field(Parameter; Rec.Parameter)
                {
                    ToolTip = 'Specifies the value of the Parameter field.';
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                }
            }
        }
    }
}
