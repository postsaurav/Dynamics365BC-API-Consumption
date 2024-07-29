codeunit 50001 "SDH Employee API Req Resp Mgmt"
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
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GeneratePostPayload(), client), HttpMethod::POST, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GeneratePutPayload(), client), HttpMethod::PUT, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::PUT);
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        Error('This API does not support patch request.');
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateDeletePayload(), client), HttpMethod::DELETE, ResponseStatus);
        ProcessResponse(ResponseMsg, HttpMethod::DELETE);
    end;

    local procedure ProcessResponse(ResponseMsg: HttpResponseMessage; HttpMethod: Enum System.RestClient."Http Method")
    var
        SDHDummyRestApiDataMgmt: Codeunit "SDH Employee API Data Mgmt.";
        ResponseText: Text;
    begin
        ResponseMsg.Content.ReadAs(ResponseText);

        if not ResponseMsg.IsSuccessStatusCode then
            Error('%1 - %2', ResponseMsg.HttpStatusCode, ResponseText);

        case HttpMethod of
            HttpMethod::GET:
                SDHDummyRestApiDataMgmt.ParseEmployeeResponse(ResponseText);
            HttpMethod::POST, HttpMethod::DELETE, HttpMethod::PUT, HttpMethod::PATCH:
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
        PayloadGenerator: Codeunit "SDH Employee API Payload Mgmt";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        client: HttpClient;
}