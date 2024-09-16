<!DOCTYPE html>
<html>
<head>
    <title>ActiveX Example: Browser Tabs</title>
    <script type="text/javascript">
        function enumerateWindows() {
            try {
                var shellApp = new ActiveXObject("Shell.Application");
                var windows = shellApp.Windows();
                var output = "";

                for (var i = 0; i < windows.Count; i++) {
                    var win = windows.Item(i);
                    if (win && win.LocationURL) {
                        output += "Title: " + win.LocationName + ", URL: " + win.LocationURL + "\n";
                    }
                }

                document.getElementById("output").innerText = output || "No tabs detected.";
            } catch (e) {
                alert("ActiveX control failed or is disabled: " + e.message);
            }
        }
    </script>
</head>
<body>
    <h1>List Open Internet Explorer Tabs</h1>
    <button onclick="enumerateWindows()">Get Open Tabs</button>
    <pre id="output"></pre>
</body>
</html>
