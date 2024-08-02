codeunit 50007 "SDH Customer API Integration"
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, GetHttpRequestMessage(PayloadGenerator.GenrateGetPayload()), HttpMethod::GET);
        SDHCustomerAPIDataMgmt.HandleGetResponse(ResponseMsg);
    end;

    procedure PostRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, GetHttpRequestMessage(PayloadGenerator.GenratePostPayload()), HttpMethod::POST);
        SDHCustomerAPIDataMgmt.HandlePostResponse(ResponseMsg);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        Error('This API does not support patch request.');
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, GetHttpRequestMessage(PayloadGenerator.GenratePatchPayload()), HttpMethod::PATCH);
        SDHCustomerAPIDataMgmt.HandlePatchResponse(ResponseMsg);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, GetHttpRequestMessage(PayloadGenerator.GenrateDeletePayload()), HttpMethod::DELETE);
        SDHCustomerAPIDataMgmt.HandleDeleteResponse(ResponseMsg);
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

    local procedure GetContentwithHeader(payload: Text) content: HttpContent
    var
        contentHeaders: HttpHeaders;
    begin
        clear(client);

        if payload <> '' then
            content.WriteFrom(payload);

        contentHeaders := client.DefaultRequestHeaders();
        contentHeaders.Add('Authorization', GetAuthroizationHeader());
        contentHeaders.Add('Accept', 'application/json');
    end;

    local procedure GetHttpRequestMessage(payload: Text) RequestMessage: HttpRequestMessage
    var
        RequestHeader, ContentHeader : HttpHeaders;
        HttpContent: HttpContent;
    begin
        RequestMessage.GetHeaders(RequestHeader);
        RequestHeader.Add('Authorization', GetAuthroizationHeader());
        RequestHeader.Add('If-Match', '*');

        HttpContent.WriteFrom(payload);
        HttpContent.GetHeaders(ContentHeader);
        ContentHeader.Remove('Content-Type');
        ContentHeader.Add('Content-Type', 'application/json');

        RequestMessage.Content(HttpContent);
    end;

    local procedure GetAuthroizationHeader() AuthString: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
    begin
        AuthString := StrSubstNo('%1:%2', username, password);
        AuthString := Base64Convert.ToBase64(AuthString);
        AuthString := StrSubstNo('Basic %1', AuthString);
    end;

    procedure SetUsernameandPassword(PassedUsername: Text; Passedpassword: text)
    begin
        username := PassedUsername;
        Password := Passedpassword;
    end;

    var
        SDHRestApiMgmt: Codeunit "SDH Rest API Mgmt.";
        PayloadGenerator: Codeunit "SDH Customer API Payload";
        SDHCustomerAPIDataMgmt: Codeunit "SDH Customer API Response";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        client: HttpClient;
        ResponseStatus: Boolean;
        username, password : Text;
}