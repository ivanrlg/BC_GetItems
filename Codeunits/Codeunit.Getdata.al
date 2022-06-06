codeunit 60101 GetData
{
    trigger OnRun()
    begin
    end;

    procedure Ping(): Text
    begin
        exit('Pong')
    end;

    procedure GetItemsToJson(): Text
    var
        Item: Record Item;
        JSONProperty: JsonObject;
        mJsonArray: JsonArray;
        BigText: Text;
        Helper: Codeunit Helper;
        FieldRef: FieldRef;
        Ref: RecordRef;
    begin
        Item.SetRange("No.", '1900-S', '2000-S');
        Item.FindSet();

        repeat
            Clear(JSONProperty);

            Ref.GetTable(Item);

            FieldRef := Ref.Field(92);

            JSONProperty.Add('No', Item."No.");
            JSONProperty.Add('Description', Item.Description);
            JSONProperty.Add('UnitPrice', Item."Unit Price");
            JSONProperty.Add('UnitCost', Item."Unit Cost");
            JSONProperty.Add('UnitOfMeasure', Item."Base Unit of Measure");
            JSONProperty.Add('Picture', Helper.GetBase64(Ref.Number, FieldRef));

            mJsonArray.Add(JSONProperty);
        until Item.Next() = 0;

        mJsonArray.WriteTo(BigText);
        exit(BigText);
    end;
}

