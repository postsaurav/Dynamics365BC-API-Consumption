codeunit 50001 "SDH Employee API Integration"
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateGetPayload()), HttpMethod::GET);
        SDHDummyRestApiDataMgmt.HandleGetResponse(ResponseMsg);
    end;

    procedure PostRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GeneratePostPayload()), HttpMethod::POST);
        SDHDummyRestApiDataMgmt.HandlePostResponse(ResponseMsg);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GeneratePutPayload()), HttpMethod::PUT);
        SDHDummyRestApiDataMgmt.HandlePutResponse(ResponseMsg);
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        Error('This API does not support patch request.');
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateDeletePayload()), HttpMethod::DELETE);
        SDHDummyRestApiDataMgmt.HandleDeleteResponse(ResponseMsg);
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

    procedure GetContentwithHeader(payload: Text) content: HttpContent
    var
        contentHeaders: HttpHeaders;
    begin
        clear(client);
        if payload <> '' then
            content.WriteFrom(payload);

        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
    end;

    var
        SDHRestApiMgmt: Codeunit "SDH Rest API Mgmt.";
        PayloadGenerator: Codeunit "SDH Employee API Payload";
        SDHDummyRestApiDataMgmt: Codeunit "SDH Employee API Response";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        client: HttpClient;
}