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
                ParseEmployeeResponse(OutputString);
            end else
                Error('Error: %1', response.ReasonPhrase);
    end;

    procedure CreateRecords()
    var
        client: HttpClient;
        content: HttpContent;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        OutputString: Text;
    begin
        request.SetRequestUri('https://dummy.restapiexample.com/api/v1/create');
        request.Method := 'Post';
        content.WriteFrom(GeneratePayload());
        request.content(content);
        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(OutputString);
                Message('%1', OutputString);
            end else
                Error('Error: %1', response.ReasonPhrase);
    end;

    local procedure ParseEmployeeResponse(OutputString: Text)
    var
        EmployeeJson, EmployeeObject : JsonObject;
        EmployessArray: JsonArray;
        StatusJsonToken, EmployeesToken, EmployeeToken, ResultToken : JsonToken;
        ResponseID, ResponseAge : Integer;
        ResponseName: Text;
        ResponseSalary: Decimal;
    begin
        EmployeeJson.ReadFrom(OutputString);

        if EmployeeJson.Get('status', StatusJsonToken) then
            if StatusJsonToken.AsValue().AsText() <> 'success' then
                exit;
        if EmployeeJson.Get('data', EmployeesToken) then
            if EmployeesToken.IsArray() then
                EmployessArray := EmployeesToken.AsArray();

        foreach EmployeeToken in EmployessArray do begin

            EmployeeObject := EmployeeToken.AsObject();

            EmployeeObject.get('id', ResultToken);
            ResponseID := ResultToken.AsValue().AsInteger();

            EmployeeObject.get('employee_name', ResultToken);
            ResponseName := ResultToken.AsValue().AsText();

            EmployeeObject.get('employee_salary', ResultToken);
            ResponseSalary := ResultToken.AsValue().AsDecimal();

            EmployeeObject.get('employee_age', ResultToken);
            ResponseAge := ResultToken.AsValue().AsInteger();

            WriteRecordsinDatabase(ResponseID, ResponseName, ResponseSalary, ResponseAge);
        end;
    end;

    local procedure WriteRecordsinDatabase(var ResponseID: Integer; var ResponseName: Text; var ResponseSalary: Decimal; var ResponseAge: Integer)
    var
        DemoTable: Record "SDH Demo Table";
    begin
        If ResponseID = 0 then
            exit;

        if DemoTable.Get(ResponseID) then
            exit;

        DemoTable.Init();
        DemoTable.Validate(id, ResponseID);
        DemoTable.Validate(employee_name, ResponseName);
        DemoTable.Validate(employee_salary, ResponseSalary);
        DemoTable.Validate(employee_age, ResponseAge);
        DemoTable.Insert(true);

        clear(ResponseID);
        clear(ResponseName);
        clear(ResponseSalary);
        clear(ResponseAge);
    end;

    local procedure GeneratePayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('employee_name', 'test');
        JsonPayload.Add('employee_salary', 123);
        JsonPayload.Add('employee_age', 23);
        JsonPayload.WriteTo(Payload);
        Message(Payload);
    end;
}