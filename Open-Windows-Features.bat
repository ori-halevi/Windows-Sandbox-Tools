@echo off
:: This script opens the "Windows Features" dialog to help you enable Windows Sandbox.
:: Once open, scroll down and look for "Windows Sandbox", check it, and click OK.
echo.
echo ==========================================
echo   Opening Windows Optional Features...
echo ==========================================
echo.
echo Please look for "Windows Sandbox" in the list.
echo If it's not checked, check it and click OK.
echo Note: You might need to restart your computer afterwards.
echo.

start optionalfeatures.exe

pause
