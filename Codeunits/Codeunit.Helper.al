codeunit 60102 Helper
{
    trigger OnRun()
    begin

    end;

    procedure GetBase64("Table ID": Integer; FieldRef: FieldRef): Text
    var
        RecordRefImage: RecordRef;
        Base64: Codeunit "Base64 Convert";
        TenantMedia: Record "Tenant Media";
        ItemRec: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        EmployeeRec: Record Employee;
        TextOutput: Text;
        InStream: InStream;
    begin

        case "Table ID" of
            DATABASE::Item:
                begin
                    RecordRefImage := FieldRef.Record();
                    ItemRec.Get(RecordRefImage.RecordId);
                    if (ItemRec.Picture.Count > 0) then begin
                        if TenantMedia.Get(ItemRec.Picture.Item(1)) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NoPicture.png';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NoPicture.png';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Customer:
                begin
                    RecordRefImage := FieldRef.Record();
                    CustomerRec.Get(RecordRefImage.RecordId);
                    if (CustomerRec.Image.HasValue) then begin
                        if TenantMedia.Get(CustomerRec.Image.MediaId) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NoPicture.png';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NoPicture.png';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Vendor:
                begin
                    RecordRefImage := FieldRef.Record();
                    VendorRec.Get(RecordRefImage.RecordId);
                    if (VendorRec.Image.HasValue) then begin
                        if TenantMedia.Get(VendorRec.Image) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NoPicture.png';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NoPicture.png';
                        exit(TextOutput);
                    end;
                end;
            DATABASE::Employee:
                begin
                    RecordRefImage := FieldRef.Record();
                    EmployeeRec.Get(RecordRefImage.RecordId);
                    if (EmployeeRec.Image.HasValue) then begin
                        if TenantMedia.Get(EmployeeRec.Image) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue() then begin
                                TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
                                TextOutput := Base64.ToBase64(InStream);
                                exit(TextOutput);
                            end;
                        end else begin
                            TextOutput := 'NoPicture.png';
                            exit(TextOutput);
                        end;
                    end else begin
                        TextOutput := 'NoPicture.png';
                        exit(TextOutput);
                    end;
                end;
            else begin
                    TextOutput := 'Not Handled'
                end;

        end;
    end;

}