@echo off
:: ------------------ Colors ------------------
:: 0 = Black, 7 = White/Gray, A = Light Green, C = Light Red, E = Yellow
color 07

:: ------------------ Admin Check ------------------
net session >nul 2>&1 || (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

:: ------------------ Start Script ------------------
echo.
echo ============================
echo Starting Notepad Copy Tool
echo ============================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Notepad-extractor.ps1"
if %errorlevel% neq 0 (
    color C
    echo.
    echo [ERROR] Something went wrong during the Notepad copy process!
    pause
    exit /b
)

:: ------------------ Success Message ------------------
color A
echo.
echo =========================================
echo SUCCESS! Notepad and Notepad++ prepared.
echo You can now launch the Sandbox VM safely.
echo =========================================
echo.
pause
