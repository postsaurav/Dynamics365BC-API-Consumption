page 50000 "SDH Demos"
{
    ApplicationArea = All;
    Caption = 'Demos';
    PageType = List;
    Editable = false;
    SourceTable = "SDH Demo Table";
    CardPageId = "SDH Demo";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
    actions
    {
        area(Processing)
        {
            action(GetRecords)
            {
                ApplicationArea = All;
                Caption = 'Get Records';
                Image = GetEntries;
                trigger OnAction()
                var
                    APIManagement: Codeunit "SDH API Management";
                begin
                    APIManagement.GetRecords();
                end;
            }
            action(CreateRecords)
            {
                ApplicationArea = All;
                Caption = 'Create Records';
                Image = CreateDocument;
                trigger OnAction()
                var
                    APIManagement: Codeunit "SDH API Management";
                begin
                    APIManagement.CreateRecords();
                end;
            }
            action(UpdateRecords)
            {
                ApplicationArea = All;
                Caption = 'Update Records';
                Image = UpdateDescription;
                trigger OnAction()
                var
                    APIManagement: Codeunit "SDH API Management";
                begin
                    APIManagement.UpdateRecords(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(GetRecords_Ref; GetRecords) { }
            actionref(CreateRecords_ref; CreateRecords) { }
            actionref(UpdateRecord_ref; UpdateRecords) { }
        }
    }
}
