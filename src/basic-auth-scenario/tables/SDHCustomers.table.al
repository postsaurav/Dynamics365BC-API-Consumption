table 50004 "SDH Customers"
{
    Caption = 'Customers';
    LookupPageId = "SDH Customers";
    DrillDownPageId = "SDH Customers";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(5; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(6; "Source System Id"; Guid)
        {
            Caption = 'Source System Id';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    internal procedure DeleteAllImported()
    var
        Customers: Record "SDH Customers";
    begin
        if not Customers.IsEmpty() then
            Customers.DeleteAll(true);
    end;
}
