page 92404 "KEL Contact Parent Part"
{
    Caption = 'Addin';
    PageType = CardPart;
    SourceTable = Contact;

    layout
    {
        area(Content)
        {
            usercontrol(ParentAddin; KELParentAddin)
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
                    CurrPage.ParentAddin.LogApp();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.ParentAddin.SetData(rec.BuildParentStructure());
    end;
}