pageextension 92404 "KEL Contact List" extends "Contact List"
{
    layout
    {
        addlast(Control1)
        {
            field("KEL Parent Company No."; Rec."KEL Parent Company No.")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the parent company contanct no.';
                Editable = false;
            }
        }

        addfirst(factboxes)
        {
            part(KELContactTreePart; "KEL Contact Tree Part")
            {
                ApplicationArea = All;
                Caption = 'Relations';
                SubPageLink = "No." = field("No.");
            }
            part(KelContactParentPart; "KEL Contact Parent Part")
            {
                ApplicationArea = All;
                Caption = 'Relations';
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(KELBuildRelationJson)
            {
                ApplicationArea = All;
                Caption = 'Build Relation Json';
                ToolTip = 'Builds an Json document with all Parent relationships.';
                Image = Create;

                trigger OnAction()
                begin
                    Message(Rec.BuildParentStructure());
                end;
            }
            action(KELBuildHieraryJson)
            {
                ApplicationArea = All;
                Caption = 'Build Hierarchy Json';
                ToolTip = 'Builds an Json document with the hierarchy of the related Contacts.';
                Image = Create;

                trigger OnAction()
                begin
                    Message(Rec.BuildHierarchy());
                end;
            }
            action(KELFindTopNo)
            {
                ApplicationArea = All;
                Caption = 'Find Root Contact';
                ToolTip = 'Finds the Parent of all parents.';
                Image = Create;

                trigger OnAction()
                begin
                    Message(rec.FindRootContact(Rec));
                end;
            }
        }
    }
}