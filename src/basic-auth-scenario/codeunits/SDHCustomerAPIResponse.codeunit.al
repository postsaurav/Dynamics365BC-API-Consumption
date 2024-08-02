codeunit 50009 "SDH Customer API Response"
{
    internal procedure HandleGetResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        WriteRecordinDatabase(ResponseText);
        Message('Get Processed Succesfully!');
    end;

    internal procedure HandlePostResponse(ResponseMsg: HttpResponseMessage)
    begin
        ReviewResponseStatusCode(ResponseMsg);
        WriteRecordinDatabase(ResponseText);
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

    local procedure WriteRecordinDatabase(ResponseText: Text)
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
    end;

    local procedure ReadTheObject(CustomerObject: JsonObject)
    var
        CustomerToken: JsonToken;
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

        CustomerObject.Get('number', CustomerToken);
        ResponseCustomerNo := CustomerToken.AsValue().AsCode();

        CustomerObject.Get('displayName', CustomerToken);
        Responsename := CustomerToken.AsValue().AsText();

        CustomerObject.Get('addressLine1', CustomerToken);
        ResponseAddress := CustomerToken.AsValue().AsText();

        CustomerObject.Get('addressLine2', CustomerToken);
        ResponseAddress2 := CustomerToken.AsValue().AsText();

        CustomerObject.Get('phoneNumber', CustomerToken);
        ResponsePhoneNo := CustomerToken.AsValue().AsText();

        CustomerObject.Get('id', CustomerToken);
        Evaluate(ResponseGUID, CustomerToken.AsValue().AsText());

        WriteHeaderInDatabase(ResponseCustomerNo, Responsename, ResponseAddress, ResponseAddress2, ResponsePhoneNo, ResponseGUID);
    end;

    local procedure ReadTheArray(CustomerArray: JsonArray)
    var
        CustomerToken: JsonToken;
        CustomerObject: JsonObject;
    begin
        foreach CustomerToken in CustomerArray do begin
            CustomerObject := CustomerToken.AsObject();
            ReadTheObject(CustomerObject);
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

    var
        ResponseText: Text;
}