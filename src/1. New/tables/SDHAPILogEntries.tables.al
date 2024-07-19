table 50003 "SDH API Log Entries"
{
    Caption = 'API Log Entries';
    DataClassification = CustomerContent;
    LookupPageId = "SDH API Log Entries";
    DrillDownPageId = "SDH API Log Entries";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; URL; Text[2048])
        {
            Caption = 'URL';
            ExtendedDatatype = Url;
        }
        field(3; Method; Enum "Http Method")
        {
            Caption = 'Method';
        }
        field(4; Request; Blob)
        {
            Caption = 'Request';
        }
        field(5; Response; Blob)
        {
            Caption = 'Response';
        }
        field(6; "Response Code"; Integer)
        {
            Caption = 'Response Code';
        }
        field(7; Succesful; Boolean)
        {
            Caption = 'Succesful';
        }
        field(8; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
        }
        field(9; "Logged On"; Date)
        {
            Caption = 'Logged On';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure DownloadRequest()
    var
        Instr: InStream;
        FileName: Text;
    begin
        if not rec.Request.HasValue() then
            exit;
        Rec.SetAutoCalcFields(Request);
        Rec.Request.CreateInStream(Instr);
        FileName := Format(Rec."Entry No.") + '_' + Format(Rec.Method) + '_' + Rec."Requested By" + '_Request.json';
        DownloadFromStream(Instr, 'Export Request', '', 'Json Files (*.json)|*.json', FileName);
    end;

    procedure DownloadResponse()
    var
        Instr: InStream;
        FileName: Text;
    begin
        if not rec.Response.HasValue() then
            exit;
        Rec.SetAutoCalcFields(Response);
        Rec.Response.CreateInStream(Instr);
        FileName := Format(Rec."Entry No.") + '_' + Format(Rec.Method) + '_' + Rec."Requested By" + '_Response.json';
        DownloadFromStream(Instr, 'Export Request', '', 'Json Files (*.json)|*.json', FileName);
    end;

    procedure AddNewLogEntry(URLToAccess: Text; HttpMethod: Enum System.RestClient."Http Method"; RequestStream: InStream; ResponseStream: InStream; ResponseCode: Integer; Sucess: Boolean)
    var
        LogEntry: Record "SDH API Log Entries";
    begin
        LogEntry.Init();
        LogEntry.URL := URLToAccess;
        LogEntry.Method := HttpMethod;
        LogEntry."Response Code" := ResponseCode;
        LogEntry.Succesful := Sucess;
        LogEntry."Requested By" := USERID;
        LogEntry."Logged On" := Today();
        LogEntry.Insert(true);
        HandleStreams(LogEntry, RequestStream, ResponseStream);
    end;

    local procedure HandleStreams(var LogEntry: Record "SDH API Log Entries"; RequestStream: InStream; ResponseStream: InStream)
    var
        OutStr: OutStream;
    begin
        clear(OutStr);
        LogEntry.Request.CreateOutStream(OutStr);
        CopyStream(OutStr, RequestStream);
        LogEntry.Modify();

        clear(OutStr);
        LogEntry.Response.CreateOutStream(OutStr);
        CopyStream(OutStr, ResponseStream);
        LogEntry.Modify();
    end;
}
