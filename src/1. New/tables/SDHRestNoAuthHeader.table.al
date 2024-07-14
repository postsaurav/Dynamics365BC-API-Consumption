table 50001 "SDH Rest No Auth Header"
{
    Caption = 'Rest No Auth Header';
    DataClassification = CustomerContent;
    LookupPageId = "SDH Rest No Auths";
    DrillDownPageId = "SDH Rest No Auths";
    fields
    {
        field(1; id; Integer)
        {
            Caption = 'id';
        }
        field(2; name; Text[250])
        {
            Caption = 'name';
        }
    }
    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        Lines: Record "SDH Rest No Auth Line";
    begin
        Lines.SetRange(id, Rec.id);
        if not Lines.IsEmpty() then
            Lines.DeleteAll(true);
    end;

    procedure DeleteAllImported()
    var
        Header: Record "SDH Rest No Auth Header";
    begin
        if not Header.IsEmpty() then
            Header.DeleteAll(true);
    end;
}
