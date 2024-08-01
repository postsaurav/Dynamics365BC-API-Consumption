codeunit 50008 "SDH Customer API Payload Mgmt"
{
    internal procedure GenrateGetPayload() payload: Text
    begin
        payload := '';
    end;

    internal procedure GenratePostPayload() payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('displayName', 'Saurav Dhyani');
        JsonPayload.Add('addressLine1', 'Dehradun Uttrakhand');
        JsonPayload.Add('addressLine2', 'India');
        JsonPayload.Add('phoneNumber', '7812345784');
        JsonPayload.Add('email', 'postsaurav@gmail.com');
        JsonPayload.WriteTo(payload);
    end;

    internal procedure GenratePutPayload() payload: Text
    var
        JsonPayload: JsonObject;
    begin
    end;

    internal procedure GenratePatchPayload() payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('displayName', 'API Patch');
        JsonPayload.Add('phoneNumber', '9999999999');
        JsonPayload.WriteTo(payload);
    end;

    internal procedure GenrateDeletePayload() payload: Text
    begin
        payload := '';
    end;
}
