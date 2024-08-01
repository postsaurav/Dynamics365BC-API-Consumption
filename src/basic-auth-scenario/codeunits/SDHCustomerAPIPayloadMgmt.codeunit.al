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
        JsonPayload.Add('name', 'Patch Request');
        JsonPayload.WriteTo(payload);
    end;

    internal procedure GenrateDeletePayload() payload: Text
    begin
        payload := '';
    end;
}
