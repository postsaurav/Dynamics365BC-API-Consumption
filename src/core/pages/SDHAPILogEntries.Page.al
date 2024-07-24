page 50001 "SDH API Log Entries"
{
    ApplicationArea = All;
    Caption = 'API Log Entries';
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTable = "SDH API Log Entries";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(URL; Rec.URL)
                {
                    ToolTip = 'Specifies the value of the URL field.';
                }
                field(Method; Rec.Method)
                {
                    ToolTip = 'Specifies the value of the Method field.';
                }
                field(Request; Rec.Request)
                {
                    ToolTip = 'Specifies the value of the Request field.';
                }
                field(Response; Rec.Response)
                {
                    ToolTip = 'Specifies the value of the Response field.';
                }
                field("Response Code"; Rec."Response Code")
                {
                    ToolTip = 'Specifies the value of the Response Code field.';
                }
                field(Succesful; Rec.Succesful)
                {
                    ToolTip = 'Specifies the value of the Succesful field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field("Logged On"; Rec."Logged On")
                {
                    ToolTip = 'Specifies the value of the Logged On field.';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(DownloadRequest)
            {
                Caption = 'Download Request';
                Image = Download;
                trigger OnAction()
                begin
                    Rec.DownloadRequest();
                end;
            }
            action(DownloadResponse)
            {
                Caption = 'Download Response';
                Image = Download;
                trigger OnAction()
                begin
                    Rec.DownloadResponse();
                end;
            }
        }
        area(Promoted)
        {
            actionref(DownloadRequest_Ref; DownloadRequest) { }
            actionref(DownloadResponse_Ref; DownloadResponse) { }
        }
    }

}
