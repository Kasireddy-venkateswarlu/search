<!DOCTYPE html>
<html>
<head>
    <title>Delete File using ActiveX</title>
    <script type="text/javascript">
        function deleteFile() {
            try {
                var fso = new ActiveXObject("Scripting.FileSystemObject");
                var filePath = "S:\\path\\to\\your\\file.txt";  // Specify the file path here

                if (fso.FileExists(filePath)) {
                    fso.DeleteFile(filePath);
                    alert("File deleted successfully.");
                } else {
                    alert("File not found.");
                }
            } catch (e) {
                alert("An error occurred: " + e.message);
            }
        }
    </script>
</head>
<body>
    <h1>Delete File from S Drive</h1>
    <button onclick="deleteFile()">Delete File</button>
</body>
</html>

