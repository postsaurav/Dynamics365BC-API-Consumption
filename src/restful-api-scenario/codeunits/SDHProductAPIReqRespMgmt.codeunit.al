codeunit 50004 "SDH Product API Req Resp Mgmt"
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, '', HttpMethod::GET, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::GET);
    end;

    procedure PostRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH Product API Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, PayloadGenerator.GenratePostPayload(), HttpMethod::POST, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH Product API Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, PayloadGenerator.GenratePUtPayload(), HttpMethod::PUT, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::PUT);
    end;

    procedure PatchRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH Product API Payload Mgmt.";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, PayloadGenerator.GenratePatchPayload(), HttpMethod::PATCH, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::PATCH);
    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, '', HttpMethod::DELETE, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::DELETE);
    end;

    local procedure ProcessResponse(ResponseText: Text; HttpMethod: Enum System.RestClient."Http Method")
    var
        SDHAPIDataMgmt: Codeunit "SDH Product API Data Mgmt.";
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

    local procedure CheckMandatoryAndReset(URLToAccess: Text)
    begin
        if URLToAccess = '' then
            Error('URL cannot be empty');

        if StrPos(URLToAccess, '%1') > 0 then
            Error('Execute URL cannot have %1');

        Clear(ResponseMsg);
        Clear(HttpMethod);
        Clear(ResponseStatus);
        Clear(ResponseText);
    end;

    var
        SDHRestApiMgmt: Codeunit "SDH Rest API Mgmt.";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        ResponseText: Text;
}