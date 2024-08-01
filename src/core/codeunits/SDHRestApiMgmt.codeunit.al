codeunit 50000 "SDH Rest Api Mgmt."
{
    procedure MakeRequest(URLToAccess: Text; client: HttpClient; content: HttpContent; HttpMethod: Enum System.RestClient."Http Method"; var ResponseStatus: Boolean) response: HttpResponseMessage
    var
        request: HttpRequestMessage;
    begin
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

    procedure MakeRequest(URLToAccess: Text; request: HttpRequestMessage; HttpMethod: Enum System.RestClient."Http Method"; var ResponseStatus: Boolean) response: HttpResponseMessage
    var
        client: HttpClient;
    begin
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
}