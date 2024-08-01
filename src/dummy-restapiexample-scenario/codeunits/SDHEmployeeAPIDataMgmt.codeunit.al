codeunit 50003 "SDH Employee API Data Mgmt."
{
    internal procedure ParseEmployeeResponse(OutputString: Text)
    var
        EmployeeJson, EmployeeObject : JsonObject;
        EmployessArray: JsonArray;
        StatusJsonToken, EmployeesToken, EmployeeToken, ResultToken : JsonToken;
        ResponseID, ResponseAge : Integer;
        ResponseName: Text;
        ResponseSalary: Decimal;
    begin
        EmployeeJson.ReadFrom(OutputString);

        if not EmployeeJson.Get('status', StatusJsonToken) then
            Error('Invalid Response!');

        if StatusJsonToken.AsValue().AsText() <> 'success' then
            Error('Invalid Response!');

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
            Message('Response Processed Succesfully!');
        end;
    end;

    local procedure WriteRecordsinDatabase(var ResponseID: Integer; var ResponseName: Text; var ResponseSalary: Decimal; var ResponseAge: Integer)
    var
        DemoTable: Record "SDH Employees";
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
}