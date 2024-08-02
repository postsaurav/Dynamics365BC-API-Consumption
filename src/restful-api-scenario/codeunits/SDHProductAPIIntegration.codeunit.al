codeunit 50004 "SDH Product API Integration"
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateGetPayload()), HttpMethod::GET);
        SDHAPIDataMgmt.HandleGetResponse(ResponseMsg);
    end;

    procedure PostRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePostPayload()), HttpMethod::POST);
        SDHAPIDataMgmt.HandlePostResponse(ResponseMsg);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePutPayload()), HttpMethod::PUT);
        SDHAPIDataMgmt.HandlePutResponse(ResponseMsg);
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenratePatchPayload()), HttpMethod::PATCH);
        SDHAPIDataMgmt.HandlePatchResponse(ResponseMsg);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, client, GetContentwithHeader(PayloadGenerator.GenrateDeletePayload()), HttpMethod::DELETE);
        SDHAPIDataMgmt.HandleDeleteResponse(ResponseMsg);
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
        PayloadGenerator: Codeunit "SDH Product API Payload";
        SDHAPIDataMgmt: Codeunit "SDH Product API Response";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        client: HttpClient;
}