codeunit 50003 "SDH API No Auth Data Mgmt."
{
    internal procedure WriteRecordinDatabase(ResponseText: Text)
    var
        RestJsonObject: JsonObject;
        RestJsonArray: JsonArray;
        IsObject: Boolean;
    begin
        IsObject := RestJsonObject.ReadFrom(ResponseText);
        if not IsObject then
            if not RestJsonArray.ReadFrom(ResponseText) then
                Error('Invalid JSON format');

        if IsObject then
            ReadTheObject(RestJsonObject)
        else
            ReadTheArray(RestJsonArray);
    end;

    local procedure ReadTheObject(RestJsonObject: JsonObject)
    var
        SubRestJsonObject: JsonObject;
        ResultToken: JsonToken;
        ResponseID, i : Integer;
        parameterkeys: List of [Text];
        Responsename: Text;
    begin
        clear(ResponseID);
        clear(Responsename);

        RestJsonObject.Get('id', ResultToken);
        ResponseID := ResultToken.AsValue().AsInteger();

        RestJsonObject.Get('name', ResultToken);
        Responsename := ResultToken.AsValue().AsText();

        WriteHeaderInDatabase(ResponseID, Responsename);

        if RestJsonObject.Get('data', ResultToken) then
            if ResultToken.IsObject() then begin
                SubRestJsonObject := ResultToken.AsObject();
            end;

        parameterkeys := SubRestJsonObject.Keys();

        for i := 1 to parameterkeys.Count() do begin
            SubRestJsonObject.get(parameterkeys.Get(i), ResultToken);
            writeLineinDatabase(ResponseID, parameterkeys.Get(i), ResultToken.AsValue().AsText());
        end;
    end;

    local procedure ReadTheArray(RestJsonArray: JsonArray)
    var
        RestJsonToken: JsonToken;
        RestJsonObject: JsonObject;
    begin
        foreach RestJsonToken in RestJsonArray do begin
            RestJsonObject := RestJsonToken.AsObject();
            ReadTheObject(RestJsonObject);
        end;

    end;

    local procedure WriteHeaderInDatabase(ResponseID: Integer; Responsename: Text)
    var
        SDHRestNoAuthHeader: Record "SDH Rest No Auth Header";
    begin
        if ResponseID = 0 then
            exit;

        if SDHRestNoAuthHeader.Get(ResponseID) then
            exit;

        SDHRestNoAuthHeader.Init();
        SDHRestNoAuthHeader.id := ResponseID;
        SDHRestNoAuthHeader.name := Responsename;
        SDHRestNoAuthHeader.Insert(true);
    end;

    local procedure writeLineinDatabase(ResponseID: Integer; Param: Text; Val: Text)
    var
        SDHRestNoAuthLine: Record "SDH Rest No Auth Line";
    begin
        if ResponseID = 0 then
            exit;

        SDHRestNoAuthLine.SetRange("id", ResponseID);
        SDHRestNoAuthLine.SetRange(Parameter, Param);
        if not SDHRestNoAuthLine.IsEmpty() then
            exit;

        SDHRestNoAuthLine.Init();
        SDHRestNoAuthLine.id := ResponseID;
        SDHRestNoAuthLine."Line No." := 0;
        SDHRestNoAuthLine.Parameter := Param;
        SDHRestNoAuthLine.Value := Val;
        SDHRestNoAuthLine.Insert(true);
    end;


}
