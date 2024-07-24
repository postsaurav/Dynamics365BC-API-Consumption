table 50001 "SDH Employees"
{
    Caption = 'Employees';
    DataClassification = CustomerContent;
    DrillDownPageId = "SDH Employees";
    LookupPageId = "SDH Employees";
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

    internal procedure DeleteAllImported()
    var
        Employees: Record "SDH Employees";
    begin
        if not Employees.IsEmpty() then
            Employees.DeleteAll(true);
    end;
}