table 50000 "SDH Demo Table"
{
    Caption = 'Demo Table';
    DataClassification = CustomerContent;
    DrillDownPageId = "SDH Demos";
    LookupPageId = "SDH Demos";
    DataCaptionFields = id, employee_name;
    fields
    {
        field(1; "id"; Integer)
        {
            Caption = 'ID';
        }
        field(2; "employee_name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(3; "employee_salary"; Decimal)
        {
            Caption = 'Employee Salary';
        }
        field(4; "employee_age"; Integer)
        {
            Caption = 'Employee Age';
        }
    }
    keys
    {
        key(PK; "id")
        {
            Clustered = true;
        }
    }
}