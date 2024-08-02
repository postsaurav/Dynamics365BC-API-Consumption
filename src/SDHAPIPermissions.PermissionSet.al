permissionset 50000 "SDH API Permissions"
{
    Assignable = true;
    Caption = 'API Permissions', MaxLength = 30;
    Permissions = table "SDH Employees" = X,
        tabledata "SDH Employees" = RMID,
        page "SDH Employees" = X,
        page "SDH Employee" = X,
        codeunit "SDH Employee API Response" = X,
        tabledata "SDH API Log Entries" = RIMD,
        tabledata "SDH Product Header" = RIMD,
        tabledata "SDH Product Lines" = RIMD,
        table "SDH API Log Entries" = X,
        table "SDH Product Header" = X,
        table "SDH Product Lines" = X,
        codeunit "SDH Employee API Payload" = X,
        codeunit "SDH Employee API Integration" = X,
        codeunit "SDH Product API Response" = X,
        codeunit "SDH Product API Payload" = X,
        codeunit "SDH Product API Integration" = X,
        codeunit "SDH Rest Api Mgmt." = X,
        page "SDH API Handler" = X,
        page "SDH API Log Entries" = X,
        page "SDH Product" = X,
        page "SDH Product Subform" = X,
        page "SDH Products" = X,
        tabledata "SDH Customers" = RIMD,
        table "SDH Customers" = X,
        codeunit "SDH Customer API Integration" = X,
        codeunit "SDH Customer API Payload" = X,
        codeunit "SDH Customer API Response" = X,
        page "SDH Customer" = X,
        page "SDH Customers" = X;
}