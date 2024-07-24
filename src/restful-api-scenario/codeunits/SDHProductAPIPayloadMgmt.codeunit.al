codeunit 50005 "SDH Product API Payload Mgmt."
{

    internal procedure GenrateGetPayload() payload: Text
    begin
        payload := '';
    end;

    internal procedure GenratePostPayload() payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Saurav dhyani');
        JsonPayload.Add('data', GetDataObject());
        JsonPayload.WriteTo(payload);
    end;

    internal procedure GenratePutPayload() payload: Text
    var
        JsonPayload: JsonObject;
    begin
        JsonPayload.Add('name', 'Put Request');
        JsonPayload.Add('data', GetDataObject());
        JsonPayload.WriteTo(payload);
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


    local procedure GetDataObject() DataObject: JsonObject
    begin
        DataObject.Add('year', 1984);
        DataObject.Add('exp', 14);
        DataObject.Add('Product', 'Business Central');
        DataObject.Add('City', 'Dehradun, India');
    end;
}
