controladdin KELParentAddin
{
    Images = 'Addin/public/build/bundle.js';
    StyleSheets = 'Addin/public/build/bundle.css';
    Scripts = 'src/parentaddin/interface.js';
    StartupScript = 'src/parentaddin/startup.js';

    HorizontalStretch = true;
    HorizontalShrink = true;
    VerticalStretch = true;
    VerticalShrink = true;
    RequestedHeight = 300;

    event ControlReady();
    event LookupContact(ContactNo: Code[20]);

    procedure LogApp();
    procedure SetData(AppData: Text);
}