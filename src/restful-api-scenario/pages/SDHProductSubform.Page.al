page 50006 "SDH Product Subform"
{
    ApplicationArea = All;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "SDH Product Lines";

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
