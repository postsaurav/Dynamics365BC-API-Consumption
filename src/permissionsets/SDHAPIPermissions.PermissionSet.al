permissionset 50000 "SDH API Permissions"
{
    Assignable = true;
    Caption = 'API Permissions', MaxLength = 30;
    Permissions = table "SDH Demo Table" = X,
        tabledata "SDH Demo Table" = RMID,
        page "SDH Demos" = X,
        page "SDH Demo" = X,
        codeunit "SDH API No Auth Mgmt." = X,
        codeunit "SDH API Request Response" = X;
}