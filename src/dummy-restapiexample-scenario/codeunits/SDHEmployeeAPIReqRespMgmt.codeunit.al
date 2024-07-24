codeunit 50001 "SDH Employee API Req Resp Mgmt"
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
        PayloadGenerator: Codeunit "SDH Employee API Payload Mgmt";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, PayloadGenerator.GeneratePostPayload(), HttpMethod::POST, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::POST);
    end;

    procedure PutRecord(URLToAccess: Text)
    var
        PayloadGenerator: Codeunit "SDH Employee API Payload Mgmt";
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := SDHRestApiMgmt.MakeRequest(URLToAccess, PayloadGenerator.GeneratePUTPayload(), HttpMethod::PUT, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::PUT);
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
        SDHDummyRestApiDataMgmt: Codeunit "SDH Employee API Data Mgmt.";
    begin
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
        Clear(ResponseText);
    end;

    var
        SDHRestApiMgmt: Codeunit "SDH Rest API Mgmt.";
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        ResponseText: Text;

}