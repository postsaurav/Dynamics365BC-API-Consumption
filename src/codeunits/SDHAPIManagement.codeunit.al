codeunit 50000 "SDH API Management"
{
    procedure GetRecords()
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        OutputString: Text;
    begin
        request.SetRequestUri('https://dummy.restapiexample.com/api/v1/employees');
        request.Method := 'Get';
        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(OutputString);
                Message('%1', OutputString);
            end else
                Error('Error: %1', response.ReasonPhrase);
    end;
}