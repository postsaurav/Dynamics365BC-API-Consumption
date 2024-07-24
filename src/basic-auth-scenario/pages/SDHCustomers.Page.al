page 50007 "SDH Customers"
{
    ApplicationArea = All;
    Caption = 'Customers';
    PageType = List;
    SourceTable = "SDH Customers";
    CardPageId = "SDH Customer";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Source System Id"; Rec."Source System Id")
                {
                    ToolTip = 'Specifies the value of the Source System Id field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteImported)
            {
                ApplicationArea = All;
                Caption = 'Delete All';
                Image = DeleteAllBreakpoints;
                trigger OnAction()
                begin
                    if Confirm('Do you want to delete all record?') then
                        Rec.DeleteAllImported();
                end;
            }
        }
        area(Promoted)
        {
            actionref(DeleteImported_Ref; DeleteImported) { }
        }
    }
}
