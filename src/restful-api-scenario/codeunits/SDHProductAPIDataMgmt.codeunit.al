codeunit 50006 "SDH Product API Data Mgmt."
{
    internal procedure WriteRecordinDatabase(ResponseText: Text; IsNotReserved: Boolean)
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
            ReadTheObject(RestJsonObject, IsNotReserved)
        else
            ReadTheArray(RestJsonArray, IsNotReserved);
        Message('Response Processed Succesfully!');
    end;

    local procedure ReadTheObject(RestJsonObject: JsonObject; IsNotReserved: Boolean)
    var
        SubRestJsonObject: JsonObject;
        ResultToken: JsonToken;
        i: Integer;
        parameterkeys: List of [Text];
        Responsename: Text;
        ResponseID: Code[50];
    begin
        clear(ResponseID);
        clear(Responsename);

        RestJsonObject.Get('id', ResultToken);
        ResponseID := ResultToken.AsValue().AsCode();

        RestJsonObject.Get('name', ResultToken);
        Responsename := ResultToken.AsValue().AsText();

        WriteHeaderInDatabase(ResponseID, Responsename, IsNotReserved);

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

    local procedure ReadTheArray(RestJsonArray: JsonArray; IsNotReserved: Boolean)
    var
        RestJsonToken: JsonToken;
        RestJsonObject: JsonObject;
    begin
        foreach RestJsonToken in RestJsonArray do begin
            RestJsonObject := RestJsonToken.AsObject();
            ReadTheObject(RestJsonObject, IsNotReserved);
        end;

    end;

    local procedure WriteHeaderInDatabase(ResponseID: Code[50]; Responsename: Text; IsNotReserved: Boolean)
    var
        SDHRestNoAuthHeader: Record "SDH Product Header";
    begin
        if ResponseID = '' then
            exit;

        if SDHRestNoAuthHeader.Get(ResponseID) then
            exit;

        SDHRestNoAuthHeader.Init();
        SDHRestNoAuthHeader.id := ResponseID;
        SDHRestNoAuthHeader.name := Responsename;
        sdhRestNoAuthHeader."Not Reserved" := IsNotReserved;
        SDHRestNoAuthHeader.Insert(true);
    end;

    local procedure writeLineinDatabase(ResponseID: Code[50]; Param: Text; Val: Text)
    var
        SDHRestNoAuthLine: Record "SDH Product Lines";
    begin
        if ResponseID = '' then
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