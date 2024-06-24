page 50001 "SDH Demo"
{
    ApplicationArea = All;
    Caption = 'Demo';
    PageType = Card;
    SourceTable = "SDH Demo Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(employee_name; Rec.employee_name)
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(employee_age; Rec.employee_age)
                {
                    ToolTip = 'Specifies the value of the Employee Age field.';
                }
                field(employee_salary; Rec.employee_salary)
                {
                    ToolTip = 'Specifies the value of the Employee Salary field.';
                }
            }
        }
    }
}
