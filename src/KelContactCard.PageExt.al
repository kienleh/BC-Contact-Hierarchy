pageextension 92405 "KEL Contact Card" extends "Contact Card"
{
    layout
    {
        addlast(General)
        {
            field("KEL Parent Company No."; Rec."KEL Parent Company No.")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the parent company contanct no.';
                Enabled = ParentCompNoEnabled;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ParentCompNoEnabled := Rec.Type = Rec.Type::Company;
    end;

    var
        ParentCompNoEnabled: Boolean;
}