page 50000 "SDH API Handler"
{
    Caption = 'API Handler';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Group1)
            {
                Caption = 'No-Auth Dummy Rest API';
                group(Group1Refrences)
                {
                    Caption = 'References';
                    field(Group1AuthUrl; DummyAuthUrl)
                    {
                        Caption = 'Website';
                        Editable = false;
                        ExtendedDatatype = Url;
                    }
                    field(Group1URLToAccess; DummyUrlToAccess)
                    {
                        Caption = 'Execute URL';
                        ShowMandatory = true;
                        ExtendedDatatype = Url;
                    }
                    field(Group1output; DummyNoAuthResponse)
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Url;
                        Editable = false;
                        Caption = 'Output';
                    }
                }
                group(Group1actions)
                {
                    Caption = 'Actions';
                    grid(Group1Get)
                    {
                        GridLayout = Columns;
                        field(Group1GetSetURL; GetLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyUrlToAccess := 'https://dummy.restapiexample.com/api/v1/employees';
                            end;
                        }
                        field(Group1GetExecute; GetLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyRestAPIReqResMgmt.GetRecords(DummyUrlToAccess);
                            end;
                        }
                    }
                    grid(Group1Post)
                    {
                        GridLayout = Columns;
                        field(Group1PostSetURL; PostLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyUrlToAccess := 'https://dummy.restapiexample.com/api/v1/create';
                            end;
                        }
                        field(Group1PostExecute; PostLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyRestAPIReqResMgmt.PostRecord(DummyUrlToAccess);
                            end;
                        }
                    }
                    grid(Group1Put)
                    {
                        GridLayout = Columns;
                        field(Group1PutSetURL; PutLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyUrlToAccess := 'https://dummy.restapiexample.com/api/v1/update/%1';
                            end;
                        }
                        field(Group1PutExecute; PutLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyRestAPIReqResMgmt.PutRecord(DummyUrlToAccess);
                            end;
                        }
                    }
                    grid(Group1Patch)
                    {
                        GridLayout = Columns;
                        field(Group1PatchSetURL; PatchLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://dummy.restapiexample.com/api/v1/update/%1';
                            end;
                        }
                        field(Group1PatchExecute; PatchLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyRestAPIReqResMgmt.PatchRecord(DummyUrlToAccess);
                            end;
                        }
                    }
                    grid(Group1Delete)
                    {
                        GridLayout = Columns;
                        field(Group1DeleteSetURL; DeleteLabelURL)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyUrlToAccess := 'https://dummy.restapiexample.com/api/v1/delete/%1';
                            end;
                        }
                        field(Group1DeleteExecute; DeleteLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                DummyRestAPIReqResMgmt.DeleteRecord(DummyUrlToAccess);
                            end;
                        }
                    }
                }
            }
            group(Group2)
            {
                Caption = 'No-Auth Restful API';
                group(Group2Refrences)
                {
                    Caption = 'References';
                    field(Group2AuthUrl; NoAuthUrl)
                    {
                        Caption = 'Website';
                        Editable = false;
                        ExtendedDatatype = Url;
                    }
                    field(Group2URLToAccess; NoAuthUrlToAccess)
                    {
                        Caption = 'Execute URL';
                        ShowMandatory = true;
                        ExtendedDatatype = Url;
                    }
                    field(Group2output; NoAuthResponse)
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Url;
                        Editable = false;
                        Caption = 'Output';
                    }
                }
                group(Group2actions)
                {
                    Caption = 'Actions';
                    grid(Group2Get)
                    {
                        GridLayout = Columns;
                        field(Group2GetSetURL; GetLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://api.restful-api.dev/objects';
                            end;
                        }
                        field(Group2GetExecute; GetLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                APINoAuthReqResMgmt.GetRecords(NoAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group2Post)
                    {
                        GridLayout = Columns;
                        field(Group2PostSetURL; PostLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://api.restful-api.dev/objects';
                            end;
                        }
                        field(Group2PostExecute; PostLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                APINoAuthReqResMgmt.PostRecord(NoAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group2Put)
                    {
                        GridLayout = Columns;
                        field(Group2PutSetURL; PutLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://api.restful-api.dev/objects/%1';
                            end;
                        }
                        field(Group2PutExecute; PutLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                APINoAuthReqResMgmt.PutRecord(NoAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group2Patch)
                    {
                        GridLayout = Columns;
                        field(Group2PatchSetURL; PatchLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://api.restful-api.dev/objects/%1';
                            end;
                        }
                        field(Group2PatchExecute; PatchLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                APINoAuthReqResMgmt.PatchRecord(NoAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group2Delete)
                    {
                        GridLayout = Columns;
                        field(Group2DeleteSetURL; DeleteLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                NoAuthUrlToAccess := 'https://api.restful-api.dev/objects/%1';
                            end;
                        }
                        field(Group2DeleteExecute; DeleteLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                APINoAuthReqResMgmt.DeleteRecord(NoAuthUrlToAccess);
                            end;
                        }
                    }
                }
            }
            group(Group3)
            {
                Caption = 'Basic Auth API';
                Group(Group3Refrences)
                {
                    Caption = 'References';
                    field(Group3AuthUrl; BasicAuthUrl)
                    {
                        Caption = 'Website';
                        Editable = false;
                        ExtendedDatatype = Url;
                    }
                    field(Group3URLToAccess; BasicAuthUrlToAccess)
                    {
                        Caption = 'Execute URL';
                        ShowMandatory = true;
                        ExtendedDatatype = Url;
                    }
                    field(Username; Username)
                    {
                        Caption = 'User Name';
                        ShowMandatory = true;
                    }
                    field(Password; Password)
                    {
                        Caption = 'Password';
                        ExtendedDatatype = Masked;
                        ShowMandatory = true;
                    }
                    field(Group3output; BasicAuthResponse)
                    {
                        ApplicationArea = All;
                        ExtendedDatatype = Url;
                        Editable = false;
                        Caption = 'Output';
                    }
                }
                group(Group3actions)
                {
                    Caption = 'Actions';
                    grid(Group3Get)
                    {
                        GridLayout = Columns;
                        field(Group3GetSetURL; GetLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthUrlToAccess := 'http://localhost:7048/BC240/api/v2.0/companies(9de49c12-b738-ef11-8e52-6045bdaca463)/customers';
                            end;
                        }
                        field(Group3GetExecute; GetLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthReqResMgmt.SetUsernameandPassword(Username, Password);
                                BasicAuthReqResMgmt.GetRecords(BasicAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group3Post)
                    {
                        GridLayout = Columns;
                        field(Group3PostSetURL; PostLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthUrlToAccess := 'http://localhost:7048/BC240/api/v2.0/companies(9de49c12-b738-ef11-8e52-6045bdaca463)/customers';
                            end;
                        }
                        field(Group3PostExecute; PostLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthReqResMgmt.SetUsernameandPassword(Username, Password);
                                BasicAuthReqResMgmt.PostRecord(BasicAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group3Put)
                    {
                        GridLayout = Columns;
                        field(Group3PutSetURL; PutLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthUrlToAccess := 'http://localhost:7048/BC240/api/v2.0/companies(9de49c12-b738-ef11-8e52-6045bdaca463)/customers';
                            end;
                        }
                        field(Group3PutExecute; PutLabel)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthReqResMgmt.SetUsernameandPassword(Username, Password);
                                BasicAuthReqResMgmt.PutRecord(BasicAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group3Patch)
                    {
                        GridLayout = Columns;
                        field(Group3PatchSetURL; PatchLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthUrlToAccess := 'http://localhost:7048/BC240/api/v2.0/companies(9de49c12-b738-ef11-8e52-6045bdaca463)/customers(%1)';
                            end;
                        }
                        field(Group3PatchExecute; PatchLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthReqResMgmt.SetUsernameandPassword(Username, Password);
                                BasicAuthReqResMgmt.PatchRecord(BasicAuthUrlToAccess);
                            end;
                        }
                    }
                    grid(Group3Delete)
                    {
                        GridLayout = Columns;
                        field(Group3DeleteSetURL; DeleteLabelURL)
                        {
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthUrlToAccess := 'http://localhost:7048/BC240/api/v2.0/companies(9de49c12-b738-ef11-8e52-6045bdaca463)/customers(%1)';
                            end;
                        }
                        field(Group3DeleteExecute; DeleteLabel)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnDrillDown()
                            begin
                                BasicAuthReqResMgmt.SetUsernameandPassword(Username, Password);
                                BasicAuthReqResMgmt.DeleteRecord(BasicAuthUrlToAccess);
                            end;
                        }
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
        NoAuthResponse := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"SDH Products");
        DummyNoAuthResponse := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"SDH Employees");
        BasicAuthResponse := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"SDH Customer");
    end;

    var
        BasicAuthReqResMgmt: Codeunit "SDH Customer API Req Resp Mgmt";
        APINoAuthReqResMgmt: Codeunit "SDH Product API Req Resp Mgmt";
        DummyRestAPIReqResMgmt: Codeunit "SDH Employee API Req Resp Mgmt";
        NoAuthUrlToAccess, DummyUrlToAccess, BasicAuthUrlToAccess : Text[1024];
        NoAuthResponse, DummyNoAuthResponse, BasicAuthResponse : Text[1024];
        Username, Password : Text;
        NoAuthUrl: Label 'https://restful-api.dev/';
        DummyAuthUrl: Label 'https://dummy.restapiexample.com/';
        BasicAuthUrl: Label 'https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/api-reference/v2.0/resources/dynamics_customer';
        ResetURL: Label 'Reset URL';
        GetLabel: Label 'Get';
        PostLabel: Label 'Post';
        PutLabel: Label 'Put';
        PatchLabel: Label 'Patch';
        DeleteLabel: Label 'Delete';
        GetLabelURL: Label 'Generate Get URL';
        PostLabelURL: Label 'Generate Post URL';
        PutLabelURL: Label 'Generate Put URL';
        PatchLabelURL: Label 'Generate Patch URL';
        DeleteLabelURL: Label 'Generate Delete URL';
}
