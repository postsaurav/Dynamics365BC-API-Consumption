page 50005 "SDH Product"
{
    ApplicationArea = All;
    Caption = 'Product';
    PageType = Document;
    RefreshOnActivate = true;
    DataCaptionFields = id, name;
    SourceTable = "SDH Product Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the name field.';
                }
                field("Not Reserved"; Rec."Not Reserved")
                {
                    ToolTip = 'Specifies the value of the Not Reserved field.', Comment = '%';
                }
            }
            part(Lines; "SDH Product Subform")
            {
                ApplicationArea = All;
                SubPageLink = "id" = field("id");
                UpdatePropagation = Both;
            }
        }
    }
}
