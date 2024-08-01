codeunit 50009 "SDH Customer API Data Mgmt."
{
    internal procedure ProcessGetResponse(ResponseText: Text)
    var
        CustomerObject: JsonObject;
        CustomerArray: JsonArray;
        CustomerToken: JsonToken;
        IsObject: Boolean;
    begin
        CustomerObject.ReadFrom(ResponseText);
        IsObject := not (CustomerObject.Contains('value'));

        if not IsObject then begin
            CustomerObject.ReadFrom(ResponseText);
            CustomerObject.Get('value', CustomerToken);
            CustomerArray := CustomerToken.AsArray();
        end;

        if IsObject then
            ReadTheObject(CustomerObject)
        else
            ReadTheArray(CustomerArray);
        Message('Response Processed Succesfully!');
    end;

    local procedure ReadTheObject(RestJsonObject: JsonObject)
    var
        ResultToken: JsonToken;
        Responsename, ResponseAddress : Text[100];
        ResponseAddress2: Text[50];
        ResponsePhoneNo: Text[30];
        ResponseGUID: Guid;
        ResponseCustomerNo: Code[20];
    begin
        clear(Responsename);
        Clear(ResponseAddress);
        Clear(ResponseAddress2);
        Clear(ResponsePhoneNo);
        Clear(ResponseGUID);
        clear(ResponseCustomerNo);

        RestJsonObject.Get('number', ResultToken);
        ResponseCustomerNo := ResultToken.AsValue().AsCode();

        RestJsonObject.Get('displayName', ResultToken);
        Responsename := ResultToken.AsValue().AsText();

        RestJsonObject.Get('addressLine1', ResultToken);
        ResponseAddress := ResultToken.AsValue().AsText();

        RestJsonObject.Get('addressLine2', ResultToken);
        ResponseAddress2 := ResultToken.AsValue().AsText();

        RestJsonObject.Get('phoneNumber', ResultToken);
        ResponsePhoneNo := ResultToken.AsValue().AsText();

        RestJsonObject.Get('id', ResultToken);
        Evaluate(ResponseGUID, ResultToken.AsValue().AsText());

        WriteHeaderInDatabase(ResponseCustomerNo, Responsename, ResponseAddress, ResponseAddress2, ResponsePhoneNo, ResponseGUID);

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

    local procedure WriteHeaderInDatabase(ResponseCustomerNo: Code[20]; Responsename: Text[100]; ResponseAddress: Text[100]; ResponseAddress2: Text[50]; ResponsePhoneNo: Text[30]; ResponseGUID: Guid)
    var
        SDHCustomer: Record "SDH Customers";
    begin
        if SDHCustomer.Get(ResponseCustomerNo) then
            exit;
        SDHCustomer.Init();
        SDHCustomer.Validate("No.", ResponseCustomerNo);
        SDHCustomer.Validate(Name, Responsename);
        SDHCustomer.Validate(Address, ResponseAddress);
        SDHCustomer.Validate("Address 2", ResponseAddress2);
        SDHCustomer.Validate("Phone No.", ResponsePhoneNo);
        SDHCustomer.Validate("Source System Id", ResponseGUID);
        SDHCustomer.Insert(true);
    end;
}