# Define the path to your large .DMP file
$largeFilePath = "C:\path\to\your\file.dmp"

# Define the list of keywords to search for
$keywords = @("password=", "pass=", "passwd=")

# Open the file and search line by line
Get-Content -Path $largeFilePath -ReadCount 1000 | ForEach-Object {
    $_ | Select-String -Pattern $keywords | ForEach-Object {
        Write-Output $_.Line
    }
}

