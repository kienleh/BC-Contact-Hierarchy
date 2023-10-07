function LogApp() {
    console.log(app);
}

function SetData(AppData) {
    console.log(AppData);
    app.contacts = JSON.parse(AppData);
}