@echo off
for /f "delims=" %%g in ('where git 2^>nul') do (
    "%%~dpg..\bin\bash.exe" "%~dpn0.sh" %*
    exit /b %errorlevel%
)
echo [ERROR] Git not found. Please install Git first.
exit /b 1
