codeunit 50002 "SDH Rest Api Mgmt."
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, '', HttpMethod::GET, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::GET);
    end;

    procedure PostRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH No Auth Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, PayloadGenerator.GenratePostPayload(), HttpMethod::POST, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH No Auth Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, PayloadGenerator.GenratePUtPayload(), HttpMethod::PUT, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::PUT);
    end;

    procedure PatchRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH No Auth Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, PayloadGenerator.GenratePatchPayload(), HttpMethod::PATCH, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::PATCH);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, '', HttpMethod::DELETE, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::DELETE);
    end;

    local procedure CheckMandatoryAndReset(URLToAccess: Text)
    begin
        if URLToAccess = '' then
            Error('URL cannot be empty');
        Clear(content);
        Clear(ResponseMsg);
        Clear(HttpMethod);
        Clear(ResponseStatus);
        Clear(ResponseText);
    end;

    local procedure MakeRequest(URLToAccess: Text; payload: Text; HttpMethod: Enum System.RestClient."Http Method"; var ResponseStatus: Boolean) response: HttpResponseMessage
    var
        client: HttpClient;
        contentHeaders: HttpHeaders;
        request: HttpRequestMessage;
    begin
        if payload <> '' then
            content.WriteFrom(payload);

        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

        request.Content := content;
        request.SetRequestUri(URLToAccess);

        case HttpMethod of
            HttpMethod::GET:
                request.Method := 'GET';
            HttpMethod::POST:
                request.Method := 'POST';
            HttpMethod::PUT:
                request.Method := 'PUT';
            HttpMethod::PATCH:
                request.Method := 'PATCH';
            HttpMethod::DELETE:
                request.Method := 'DELETE';
        end;
        ResponseStatus := client.Send(request, response);
        LogApiTransaction(URLToAccess, HttpMethod, ResponseStatus, request, response);
    end;

    local procedure ProcessResponse(ResponseText: Text; HttpMethod: Enum System.RestClient."Http Method")
    var
        SDHAPIDataMgmt: Codeunit "SDH API No Auth Data Mgmt.";
    begin
        case HttpMethod of
            HttpMethod::GET:
                SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, false);
            HttpMethod::POST:
                SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, true);
            HttpMethod::DELETE, HttpMethod::PUT, HttpMethod::PATCH:
                Message('%1', ResponseText);
        end;
    end;

    local procedure LogApiTransaction(URLToAccess: Text; HttpMethod: Enum System.RestClient."Http Method"; var ResponseStatus: Boolean; request: HttpRequestMessage; var response: HttpResponseMessage)
    var
        LogEntry: Record "SDH API Log Entries";
        RequestInstream, ResponseInstream : InStream;
    begin
        request.Content.ReadAs(RequestInstream);
        response.Content.ReadAs(ResponseInstream);
        LogEntry.AddNewLogEntry(URLToAccess, HttpMethod, RequestInstream, ResponseInstream, response.HttpStatusCode, ResponseStatus);
    end;



    var
        content: HttpContent;
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        ResponseText: Text;
}
