function LogApp() {
    console.log(app);
}

function SetData(AppData) {
    console.log(AppData);
    app.contact = JSON.parse(AppData);
}