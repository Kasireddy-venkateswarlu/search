<!DOCTYPE html>
<html>
<head>
    <title>ActiveX Control Example</title>
    <script type="text/javascript">
        function enumerateBrowserTabs() {
            try {
                var shell = new ActiveXObject("WScript.Shell");
                var browserWindows = shell.Exec("tasklist /FI \"IMAGENAME eq iexplore.exe\"");
                var output = browserWindows.StdOut.ReadAll();
                document.getElementById("output").innerText = output;
            } catch (e) {
                alert("ActiveX control failed or is disabled: " + e.message);
            }
        }
    </script>
</head>
<body>
    <h1>List of Internet Explorer Tabs</h1>
    <button onclick="enumerateBrowserTabs()">Get Open Tabs</button>
    <pre id="output"></pre>
</body>
</html>
