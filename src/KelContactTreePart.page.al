page 92405 "KEL Contact Tree Part"
{
    Caption = 'Addin';
    PageType = CardPart;
    SourceTable = Contact;

    layout
    {
        area(Content)
        {
            usercontrol(TreeAddin; KelTreeAddin)
            {
                ApplicationArea = All;

                trigger LookupContact(ContactNo: Code[20])
                var
                    Contact: Record Contact;
                begin
                    Contact.Get(ContactNo);
                    Page.Run(Page::"Contact Card", Contact);
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActLogApp)
            {
                Caption = 'Log App';
                ToolTip = 'Debug: Log Javascript App Object';
                ApplicationArea = All;
                Image = Debug;

                trigger OnAction()
                begin
                    CurrPage.TreeAddin.LogApp();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.TreeAddin.SetData(Rec.BuildHierarchy());
    end;
}