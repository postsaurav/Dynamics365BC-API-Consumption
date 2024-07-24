permissionset 50000 "SDH API Permissions"
{
    Assignable = true;
    Caption = 'API Permissions', MaxLength = 30;
    Permissions = table "SDH Employees" = X,
        tabledata "SDH Employees" = RMID,
        page "SDH Employees" = X,
        page "SDH Employee" = X,
        codeunit "SDH Employee API Data Mgmt." = X,
        tabledata "SDH API Log Entries" = RIMD,
        tabledata "SDH Product Header" = RIMD,
        tabledata "SDH Product Lines" = RIMD,
        table "SDH API Log Entries" = X,
        table "SDH Product Header" = X,
        table "SDH Product Lines" = X,
        codeunit "SDH Employee API Payload Mgmt" = X,
        codeunit "SDH Employee API Req Resp Mgmt" = X,
        codeunit "SDH Product API Data Mgmt." = X,
        codeunit "SDH Product API Payload Mgmt." = X,
        codeunit "SDH Product API Req Resp Mgmt" = X,
        codeunit "SDH Rest Api Mgmt." = X,
        page "SDH API Handler" = X,
        page "SDH API Log Entries" = X,
        page "SDH Product" = X,
        page "SDH Product Subform" = X,
        page "SDH Products" = X;
}