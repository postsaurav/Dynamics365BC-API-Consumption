codeunit 50006 "SDH Product API Response"
{
    internal procedure HandleGetResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        WriteRecordinDatabase(ResponseText, false);
        Message('Get Processed Succesfully!');
    end;

    internal procedure HandlePostResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        WriteRecordinDatabase(ResponseText, true);
        Message('Post Processed Succesfully!');
    end;

    internal procedure HandlePutResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        Message('%1', ResponseText);
    end;

    internal procedure HandlePatchResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        Message('%1', ResponseText);
    end;

    internal procedure HandleDeleteResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        Message('%1', ResponseText);
    end;

    local procedure ReviewResponseStatusCode(ResponseMsg: HttpResponseMessage)
    begin
        Clear(ResponseText);
        ResponseMsg.Content.ReadAs(ResponseText);
        if not ResponseMsg.IsSuccessStatusCode then
            Error('%1 - %2', ResponseMsg.HttpStatusCode, ResponseText);
    end;

    local procedure WriteRecordinDatabase(ResponseText: Text; IsNotReserved: Boolean)
    var
        ProductObject: JsonObject;
        ProductArray: JsonArray;
        IsObject: Boolean;
    begin
        IsObject := ProductObject.ReadFrom(ResponseText);

        if not IsObject then
            if not ProductArray.ReadFrom(ResponseText) then
                Error('Invalid JSON format');

        if IsObject then
            ReadTheObject(ProductObject, IsNotReserved)
        else
            ReadTheArray(ProductArray, IsNotReserved);
    end;

    local procedure ReadTheObject(ProductObject: JsonObject; IsNotReserved: Boolean)
    var
        ProductDetailObject: JsonObject;
        ProductToken: JsonToken;
        i: Integer;
        parameterkeys: List of [Text];
        Responsename: Text;
        ResponseID: Code[50];
    begin
        clear(ResponseID);
        clear(Responsename);

        ProductObject.Get('id', ProductToken);
        ResponseID := ProductToken.AsValue().AsCode();

        ProductObject.Get('name', ProductToken);
        Responsename := ProductToken.AsValue().AsText();

        WriteHeaderInDatabase(ResponseID, Responsename, IsNotReserved);

        if ProductObject.Get('data', ProductToken) then
            if ProductToken.IsObject() then begin
                ProductDetailObject := ProductToken.AsObject();
            end;

        parameterkeys := ProductDetailObject.Keys();

        for i := 1 to parameterkeys.Count() do begin
            ProductDetailObject.get(parameterkeys.Get(i), ProductToken);
            writeLineinDatabase(ResponseID, parameterkeys.Get(i), ProductToken.AsValue().AsText());
        end;
    end;

    local procedure ReadTheArray(ProductArray: JsonArray; IsNotReserved: Boolean)
    var
        ProductToken: JsonToken;
        ProductObject: JsonObject;
    begin
        foreach ProductToken in ProductArray do begin
            ProductObject := ProductToken.AsObject();
            ReadTheObject(ProductObject, IsNotReserved);
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

    var
        ResponseText: Text;
}