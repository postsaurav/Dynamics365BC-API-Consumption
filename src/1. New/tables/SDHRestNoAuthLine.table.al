table 50002 "SDH Rest No Auth Line"
{
    Caption = 'Rest No Auth Line';
    DataClassification = CustomerContent;
    LookupPageId = "SDH Rest No Auth Subform";
    DrillDownPageId = "SDH Rest No Auth Subform";
    fields
    {
        field(1; id; Integer)
        {
            Caption = 'id';
            Editable = false;
            TableRelation = "SDH Rest No Auth Header"."id";
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
        Lines: Record "SDH Rest No Auth Line";
    begin
        if Rec."Line No." = 0 then begin
            Lines.SetRange("id", Rec."id");
            if Lines.FindLast then
                Rec."Line No." := Lines."Line No." + 10000
            else
                Rec."Line No." := 10000;
        end;
    end;
}
