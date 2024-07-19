page 50005 "SDH API Handler"
{
    Caption = 'API Handler';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(InputParam)
            {
                Caption = 'Input Parameters';
                field(ResetURL; ResetURL)
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        UrlToAccess := 'https://api.restful-api.dev/objects';
                        CurrPage.Update();
                    end;
                }
                field(URLToAccess; UrlToAccess)
                {
                    Caption = 'URL';
                    ShowMandatory = true;
                    ExtendedDatatype = Url;
                }
            }
            group(restfulapi)
            {
                Caption = 'No-Auth Restful API';

                group(Refrences)
                {
                    Caption = 'Refrences and Output';

                    field(NoAuthUrl; NoAuthUrl)
                    {
                        Caption = 'Refrence URL';
                        Editable = false;
                        ExtendedDatatype = Url;
                    }
                    field(output; NoAuthResponse)
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Url;
                        Editable = false;
                        Caption = 'Result';
                    }
                }
                group(actionsrestfulapi)
                {
                    Caption = 'Actions';
                    field(GetLabel; GetLabel)
                    {
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            RestAPIMgmt.GetRecords(UrlToAccess);
                        end;
                    }
                    field(PostLabel; PostLabel)
                    {
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            RestAPIMgmt.PostRecord(UrlToAccess);
                        end;
                    }
                    field(PutLabel; PutLabel)
                    {
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            RestAPIMgmt.PutRecord(UrlToAccess);
                        end;
                    }
                    field(PatchLabel; PatchLabel)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            RestAPIMgmt.PatchRecord(UrlToAccess);
                        end;
                    }
                    field(DeleteLabel; DeleteLabel)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        trigger OnDrillDown()
                        begin
                            RestAPIMgmt.DeleteRecord(UrlToAccess);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(LogEntries)
            {
                ApplicationArea = All;
                Image = ErrorLog;
                RunObject = Page "SDH API Log Entries";
            }
        }
        area(Promoted)
        {
            actionref(LogEntries_Ref; LogEntries) { }
        }
    }

    trigger OnOpenPage()
    begin
        UrlToAccess := 'https://api.restful-api.dev/objects';
        NoAuthResponse := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"SDH Rest No Auths");
    end;

    var
        RestAPIMgmt: Codeunit "SDH Rest Api Mgmt.";
        UrlToAccess, NoAuthResponse : Text[1024];
        NoAuthUrl: Label 'https://api.restful-api.dev/objects';
        ResetURL: Label 'Reset URL';
        GetLabel: Label 'Get';
        PostLabel: Label 'Post';
        PutLabel: Label 'Put';
        PatchLabel: Label 'Patch';
        DeleteLabel: Label 'Delete';
}
