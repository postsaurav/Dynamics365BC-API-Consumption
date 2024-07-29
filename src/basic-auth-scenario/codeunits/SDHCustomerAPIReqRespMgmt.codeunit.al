codeunit 50007 "SDH Customer API Req Resp Mgmt"
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
        ProcessResponse(ResponseMsg, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        Error('This API does not support patch request.');
    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ProcessResponse(ResponseMsg, HttpMethod::PATCH);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ProcessResponse(ResponseMsg, HttpMethod::DELETE);
    end;

    local procedure ProcessResponse(ResponseMsg: HttpResponseMessage; HttpMethod: Enum System.RestClient."Http Method")
    var
        //    SDHAPIDataMgmt: Codeunit "SDH Product API Data Mgmt.";
        ResponseText: Text;
    begin
        ResponseMsg.Content.ReadAs(ResponseText);

        if not ResponseMsg.IsSuccessStatusCode then
            Error('%1 - %2', ResponseMsg.HttpStatusCode, ResponseText)
        else
            Message('%1', ResponseText);
        // case HttpMethod of
        //     HttpMethod::GET:
        //         SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, false);
        //     HttpMethod::POST:
        //         SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText, true);
        //     HttpMethod::DELETE, HttpMethod::PUT, HttpMethod::PATCH:
        //         Message('%1', ResponseText);
        // end;
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

    local procedure GetContentwithHeader(payload: Text; var updateclient: HttpClient) content: HttpContent
    var
        contentHeaders: HttpHeaders;
    begin
        if payload <> '' then
            content.WriteFrom(payload);

        contentHeaders := updateclient.DefaultRequestHeaders();
        contentHeaders.Add('Authorization', GetAuthroizationHeader());
        contentHeaders.Add('Accept', 'application/json');
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
        PayloadGenerator: Codeunit "SDH Customer API Payload Mgmt";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        client: HttpClient;
        ResponseStatus: Boolean;
        username, password : Text;

}
