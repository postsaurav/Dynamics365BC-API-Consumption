codeunit 50002 "SDH Employee API Payload"
{
    internal procedure GenrateGetPayload() payload: Text
    begin
        payload := '';
    end;

    internal procedure GeneratePostPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

    internal procedure GeneratePutPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

    internal procedure GenratePatchPayload() payload: Text
    begin
        payload := '';
    end;

    internal procedure GenrateDeletePayload() payload: Text
    begin
        payload := '';
    end;
}
