codeunit 50002 "SDH Rest Api Mgmt."
{
    procedure GetRecords(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
        ResponseMsg := MakeRequest(URLToAccess, HttpMethod::GET, ResponseStatus);
        ResponseMsg.Content.ReadAs(ResponseText);
        ProcessResponse(ResponseText, HttpMethod::GET);
    end;

    procedure PostRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);

    end;

    procedure PutRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);

    end;

    procedure PatchRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);

    end;

    procedure DeleteRecord(URLToAccess: Text)
    begin
        CheckMandatoryAndReset(URLToAccess);
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

    local procedure MakeRequest(URLToAccess: Text; HttpMethod: Enum System.RestClient."Http Method"; var ResponseStatus: Boolean) response: HttpResponseMessage
    var
        client: HttpClient;
        contentHeaders: HttpHeaders;
        request: HttpRequestMessage;
    begin
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
    end;

    local procedure ProcessResponse(ResponseText: Text; HttpMethod: Enum System.RestClient."Http Method")
    var
        SDHAPIDataMgmt: Codeunit "SDH API No Auth Data Mgmt.";
    begin
        case HttpMethod of
            HttpMethod::GET:
                SDHAPIDataMgmt.WriteRecordinDatabase(ResponseText);
        end;
    end;



    var
        content: HttpContent;
        ResponseMsg: HttpResponseMessage;
        HttpMethod: Enum "Http Method";
        ResponseStatus: Boolean;
        ResponseText: Text;
}
