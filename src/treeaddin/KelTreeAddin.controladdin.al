controladdin KelTreeAddin
{
    Images = 'TreeAddin/public/build/bundle.js';
    StyleSheets = 'TreeAddin/public/build/bundle.css';
    Scripts = 'src/treeaddin/interface.js';
    StartupScript = 'src/treeaddin/startup.js';

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