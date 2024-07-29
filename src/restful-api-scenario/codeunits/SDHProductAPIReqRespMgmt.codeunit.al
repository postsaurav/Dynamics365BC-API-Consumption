codeunit 50004 "SDH Product API Req Resp Mgmt"
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateGetPayload(), client), HttpMethod::GET, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::GET);
    end;

    procedure PostRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePostPayload(), client), HttpMethod::POST, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePutPayload(), client), HttpMethod::PUT, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::PUT);
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePatchPayload(), client), HttpMethod::PATCH, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::PATCH);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateDeletePayload(), client), HttpMethod::DELETE, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::DELETE);
    end;

    local procedure ProcessResponse(ResponseMsg: HttpResponseMessage; HttpMethod: Enum System.RestClient."Http Method")
    var
        SDHAPIDataMgmt: Codeunit "SDH Product API Data Mgmt.";
        ResponseText: Text;
    begin
        ResponseMsg.Content.ReadAs(ResponseText);

        if not ResponseMsg.IsSuccessStatusCode then
            Error('%1 - %2', ResponseMsg.HttpStatusCode, ResponseText);

        case HttpMethod of
            HttpMethod::GET:
                SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, false);
            HttpMethod::POST:
                SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, true);
            HttpMethod::DELETE, HttpMethod::PUT, HttpMethod::PATCH:
                Message('%1', ResponseText);
        end;
    end;

    local procedure CheckMandatoryAndReset(URLToAccess: Text)
    begin
        if URLToAccess = '' then
            Error('URL cannot be empty');

        if StrPos(URLToAccess, '%1') > 0 then
            Error('Execute URL cannot have %1');

        Clear(ResponseMsg);
        Clear(HttpMethod);
        Clear(ResponseStatus);
    end;

    procedure GetContentwithHeader(payload: Text; var updateclient: HttpClient) content: HttpContent
    var
        contentHeaders: HttpHeaders;
    begin
        if payload <> '' then
            content.WriteFrom(payload);

        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
    end;

    var
        SDHRestApiMgmt: Codeunit "SDH Rest API Mgmt.";
        PayloadGenerator: Codeunit "SDH Product API Payload Mgmt.";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        client: HttpClient;
}