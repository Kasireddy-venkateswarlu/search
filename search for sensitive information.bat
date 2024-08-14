@echo off
setlocal enabledelayedexpansion

:: Set keywords to search for (separate with spaces, not commas)
set "KEYWORDS=password passwd pwd pass key secret token api_key api_secret access_key access_secret login username user email phone address ssn social_security cc credit_card ccv cvv dob date_of_birth mother_name pin hostname port UserName db.user"

:: Set the log folder
set "LOG_FOLDER=C:\Users\venkateswarlu.k\Downloads"
cd /d "%LOG_FOLDER%"

:: Loop through all .ksh files in the directory
for %%f in (*.txt) do (
    set "matched="
    :: Loop through each keyword
    for %%k in (%KEYWORDS%) do (
        for /f "tokens=*" %%a in ('findstr /i /c:"%%k" "%%f"') do (
            set "matched=1"
            echo "%%f": %%a
        )
    )
    if not defined matched (
        echo "%%f": No matches found.
    )
)

pause
