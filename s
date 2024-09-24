<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete File</title>
    <script type="text/javascript">
        function deleteFile() {
            try {
                var fso = new ActiveXObject("Scripting.FileSystemObject");
                var filePath = "S:\e"; // Replace with your actual file path on S drive
                
                // Check if the file exists before attempting deletion
                if (fso.FileExists(filePath)) {
                    var file = fso.GetFile(filePath);
                    file.Delete();
                    alert("File deleted successfully!");
                } else {
                    alert("File does not exist: " + filePath);
                }
            } catch (e) {
                alert("Error deleting file: " + e.message);
            }
        }
    </script>
</head>
<body>
    <h2>Delete a File from S Drive</h2>
    <button onclick="deleteFile()">Delete File</button>
</body>
</html>
