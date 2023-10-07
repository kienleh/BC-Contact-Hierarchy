tableextension 92404 "KEL Contact" extends Contact
{
    fields
    {
        field(92404; "KEL Parent Company No."; Code[20])
        {
            Caption = 'Parent Company No.';
            TableRelation = Contact."No." where(Type = const(Company));

            trigger OnValidate()
            begin
                CheckParentRelation(Rec, Rec."No.");
            end;
        }
    }

    trigger OnDelete()
    var
        Contact: Record Contact;
    begin
        Contact.SetRange("KEL Parent Company No.", Rec."No.");
        if Contact.IsEmpty() then
            exit;
        Contact.ModifyAll("KEL Parent Company No.", '');
    end;

    local procedure CheckParentRelation(var CheckContact: Record Contact; CheckForNo: Code[20])
    var
        ParentContact: Record Contact;
        CircularRelationErr: Label 'This assignment would result in a circular relation. Contact %1 has this contact as parent.', Comment = '%1 = Contact with circular relation';
    begin
        if CheckContact."KEL Parent Company No." = '' then
            exit;

        ParentContact.Get(CheckContact."KEL Parent Company No.");
        CheckParentRelation(ParentContact, CheckForNo);

        if CheckContact."KEL Parent Company No." = CheckForNo then
            Error(CircularRelationErr, CheckContact."No.");
    end;

    #region parent structure for parentaddin
    procedure BuildParentStructure() Result: Text
    var
        ParentContact: Record Contact;
        ContactJson: JsonObject;
    begin
        Clear(Result);
        Clear(ContactJson);

        ContactJson := BuildContactObject(Rec);

        if Rec."KEL Parent Company No." <> '' then begin
            ParentContact.Get(Rec."KEL Parent Company No.");
            AddParentToJson(ParentContact, ContactJson);
        end;

        ContactJson.WriteTo(Result);
        exit(Result);
    end;

    local procedure AddParentToJson(var Contact: Record Contact; var ContactJson: JsonObject)
    var
        ParentJson: JsonObject;
    begin
        Clear(ParentJson);

        ParentJson := BuildContactObject(Contact);
        ContactJson.Add('parentContact', ParentJson);

        if Contact."KEL Parent Company No." = '' then
            exit;

        Contact.Get(Contact."KEL Parent Company No.");
        AddParentToJson(Contact, ParentJson);
    end;

    local procedure BuildContactObject(var Contact: Record Contact) ContactObject: JsonObject
    begin
        Clear(ContactObject);

        ContactObject.Add('contactNo', Contact."No.");
        ContactObject.Add('contactName', Contact.Name);
        ContactObject.Add('contactType', Contact.Type.AsInteger());

        ContactObject.Add('persons', BuildContactPersonArray(Contact));
    end;

    local procedure BuildContactPersonArray(var Contact: Record Contact) PersonArray: JsonArray
    var
        PersonContact: Record Contact;
    begin
        Clear(PersonArray);

        PersonContact.SetRange(Type, PersonContact.Type::Person);
        PersonContact.SetRange("Company No.", Contact."No.");

        if PersonContact.IsEmpty() then
            exit;

        PersonContact.FindSet();
        repeat
            PersonArray.Add(BuildContactObject(PersonContact));
        until PersonContact.Next() = 0;
    end;
    #endregion

    #region hierarchy structure
    procedure BuildHierarchy() Result: Text
    var
        TopContact: Record Contact;
        TopContactNo: Code[20];
        TreeObject: JsonObject;
    begin
        Clear(Result);
        Clear(TreeObject);

        TopContactNo := FindRootContact(Rec);
        TopContact.Get(TopContactNo);

        AddContactAndChildren(TopContact, TreeObject);
        TreeObject.Add('sourceContactNo', Rec."No.");
        TreeObject.WriteTo(Result);

        exit(Result);
    end;

    local procedure AddContactAndChildren(var Contact: Record Contact; var ContactObject: JsonObject)
    var
        ChildContact: Record Contact;
        ChildObject: JsonObject;
        ChildrenArray: JsonArray;
    begin
        Clear(ContactObject);
        Clear(ChildrenArray);

        ContactObject := BuildContactObject(Contact);

        ChildContact.SetRange(Type, ChildContact.Type::Company);
        ChildContact.SetRange("KEL Parent Company No.", Contact."No.");

        if (not ChildContact.IsEmpty()) then begin
            ChildContact.FindSet();
            repeat
                Clear(ChildObject);
                AddContactAndChildren(ChildContact, ChildObject);
                ChildrenArray.Add(ChildObject);
            until ChildContact.Next() = 0;
        end;

        ContactObject.Add('children', ChildrenArray);
    end;

    internal procedure FindRootContact(var Contact: Record Contact) ContactNo: Code[20];
    var
        NextContact: Record Contact;
    begin
        if Contact."KEL Parent Company No." <> '' then begin
            NextContact.Get(Contact."KEL Parent Company No.");
            ContactNo := FindRootContact(NextContact);
        end else
            ContactNo := Contact."No.";

        exit(ContactNo);
    end;
    #endregion
}