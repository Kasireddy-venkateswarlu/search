<!DOCTYPE html>
<html>
<head>
    <title>Enumerate Browser Tabs via ActiveX</title>
    <script type="text/javascript">
        function enumerateTabs() {
            try {
                // Create ActiveXObject for Shell.Application
                var shell = new ActiveXObject("Shell.Application");
                
                // Get all open windows
                var windows = shell.Windows();
                var output = "";

                // Loop through open windows to find Internet Explorer instances
                for (var i = 0; i < windows.Count; i++) {
                    var window = windows.Item(i);
                    // Check if window is Internet Explorer by looking for the LocationURL property
                    if (window && window.LocationURL) {
                        output += "Title: " + window.LocationName + "\n";
                        output += "URL: " + window.LocationURL + "\n\n";
                    }
                }

                // Display the result
                document.getElementById("output").innerText = output || "No active Internet Explorer tabs found.";
            } catch (e) {
                alert("Failed to enumerate tabs or ActiveX is disabled: " + e.message);
            }
        }
    </script>
</head>
<body>
    <h1>Enumerate Open Internet Explorer Tabs</h1>
    <button onclick="enumerateTabs()">Get Open Tabs</button>
    <pre id="output"></pre>
</body>
</html>
