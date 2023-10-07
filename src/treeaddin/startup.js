function docReady(fn) {
    if (document.readyState === "complete" || document.readyState === "interactive") {
      setTimeout(fn, 1);
    } else {
      document.addEventListener("DOMContentLoaded", fn);
    }
  }
  
  docReady(function () {
    SetupAddin();
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
  });
  
  function SetupAddin() {
    //container für das Datei Addin hinzufügen
    var controlHtml = "<div id='contactTreeAddin'></div>";
    var controlAddIn = document.getElementById('controlAddIn');
    controlAddIn.innerHTML = controlHtml;
  
    //Javascript aus image Resource laden
    var jsUrl = Microsoft.Dynamics.NAV.GetImageResource('TreeAddin/public/build/bundle.js');
    var jScript = document.createElement('script');
    jScript.onload = function () {
    };
    jScript.src = jsUrl;
    document.head.appendChild(jScript);
  }