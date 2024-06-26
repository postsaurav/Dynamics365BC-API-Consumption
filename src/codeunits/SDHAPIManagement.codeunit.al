codeunit 50000 "SDH API No Auth Mgmt."
{
    procedure GetRecords()
    var
        content: HttpContent;
        HttpMethod: Enum "Http Method";
        OutputString: Text;
    begin
        APIRequestResponse.SetRequestHeaders(content, '');
        OutputString := APIRequestResponse.CallAPIEndpoint(content, 'https://dummy.restapiexample.com/api/v1/employees', HttpMethod::GET);
        ParseEmployeeResponse(OutputString);
    end;

    procedure CreateRecords()
    var
        content: HttpContent;
        HttpMethod: Enum "Http Method";
        OutputString: Text;
    begin
        APIRequestResponse.SetRequestHeaders(content, GeneratePostPayload());
        OutputString := APIRequestResponse.CallAPIEndpoint(content, 'https://dummy.restapiexample.com/api/v1/create', HttpMethod::POST);
        Message('%1', OutputString);
    end;

    procedure UpdateRecords(DemoData: Record "SDH Demo Table")
    var
        content: HttpContent;
        HttpMethod: Enum "Http Method";
        OutputString: Text;
        TargetURL: Label 'https://dummy.restapiexample.com/api/v1/update/%1';
    begin
        APIRequestResponse.SetRequestHeaders(content, GeneratePUTPayload());
        OutputString := APIRequestResponse.CallAPIEndpoint(content, StrSubstNo(TargetURL, DemoData.id), HttpMethod::PUT);
        Message('%1', OutputString);
    end;

    procedure DeleteRecord(DemoData: Record "SDH Demo Table")
    var
        content: HttpContent;
        HttpMethod: Enum "Http Method";
        OutputString: Text;
        TargetURL: Label 'https://dummy.restapiexample.com/api/v1/delete/%1';
    begin
        APIRequestResponse.SetRequestHeaders(content, '');
        OutputString := APIRequestResponse.CallAPIEndpoint(content, StrSubstNo(TargetURL, DemoData.id), HttpMethod::DELETE);
        Message('%1', OutputString);
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

    local procedure GeneratePostPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

    local procedure GeneratePUTPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

    var
        APIRequestResponse: Codeunit "SDH API Request Response";
}