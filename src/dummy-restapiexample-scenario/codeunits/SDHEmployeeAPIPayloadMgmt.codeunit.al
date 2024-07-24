codeunit 50002 "SDH Employee API Payload Mgmt"
{
    internal procedure GeneratePostPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

    internal procedure GeneratePUTPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav');
        JsonPayload.Add('salary', 100);
        JsonPayload.Add('age', 39);
        JsonPayload.WriteTo(Payload);
    end;

}
