page 50002 "SDH Rest No Auth"
{
    ApplicationArea = All;
    Caption = 'Rest No Auth';
    PageType = Document;
    RefreshOnActivate = true;
    DataCaptionFields = id, name;
    SourceTable = "SDH Rest No Auth Header";

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
            }
            part(Lines; "SDH Rest No Auth Subform")
            {
                ApplicationArea = All;
                SubPageLink = "id" = field("id");
                UpdatePropagation = Both;
            }
        }
    }
}
