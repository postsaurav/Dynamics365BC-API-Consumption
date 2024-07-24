table 50002 "SDH Product Header"
{
    Caption = 'Product Header';
    DataClassification = CustomerContent;
    LookupPageId = "SDH Products";
    DrillDownPageId = "SDH Products";
    fields
    {
        field(1; id; code[50])
        {
            Caption = 'id';
        }
        field(2; name; Text[250])
        {
            Caption = 'name';
        }
        field(3; "Not Reserved"; Boolean)
        {
            Caption = 'Not Reserved';
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
        ProductLines: Record "SDH Product Lines";
    begin
        ProductLines.SetRange(id, Rec.id);
        if not ProductLines.IsEmpty() then
            ProductLines.DeleteAll(true);
    end;

    procedure DeleteAllImported()
    var
        ProductHeader: Record "SDH Product Header";
    begin
        if not ProductHeader.IsEmpty() then
            ProductHeader.DeleteAll(true);
    end;
}
