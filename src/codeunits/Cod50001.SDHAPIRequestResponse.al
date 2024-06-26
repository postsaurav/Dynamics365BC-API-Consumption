codeunit 50001 "SDH API Request Response"
{
    procedure SetRequestHeaders(var content: HttpContent; payloadbodytext: Text)
    var
        contentHeaders: HttpHeaders;
    begin
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        if payloadbodytext <> '' then
            content.WriteFrom(payloadbodytext);
    end;

    procedure CallAPIEndpoint(content: HttpContent; APIEndpoint: Text; HttpMethod: Enum "Http Method") OutputString: Text
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
    begin
        request.Content(content);
        request.SetRequestUri(APIEndpoint);

        case HttpMethod of
            HttpMethod::GET:
                request.Method := 'Get';
            HttpMethod::POST:
                request.Method := 'Post';
            HttpMethod::PUT:
                request.Method := 'PUT';
            HttpMethod::DELETE:
                request.Method := 'DELETE';
        end;

        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then
                response.Content.ReadAs(OutputString)
            else
                Error('Error: %1', response.ReasonPhrase);
    end;
}