table 50003 "SDH Product Lines"
{
    Caption = 'Product Lines';
    DataClassification = CustomerContent;
    LookupPageId = "SDH Product Subform";
    DrillDownPageId = "SDH Product Subform";
    fields
    {
        field(1; id; code[50])
        {
            Caption = 'id';
            Editable = false;
            TableRelation = "SDH Product Header"."id";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(3; Parameter; Text[250])
        {
            Caption = 'Parameter';
        }
        field(4; Value; Text[250])
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; "id", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ProductLines: Record "SDH Product Lines";
    begin
        if Rec."Line No." = 0 then begin
            ProductLines.SetRange("id", Rec."id");
            if ProductLines.FindLast then
                Rec."Line No." := ProductLines."Line No." + 10000
            else
                Rec."Line No." := 10000;
        end;
    end;
}
