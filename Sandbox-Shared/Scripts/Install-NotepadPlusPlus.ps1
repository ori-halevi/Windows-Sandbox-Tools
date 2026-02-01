# =============================== Notepad++ Setup ===============================

# Path to the Notepad++ installer in the shared folder
$notepadPlusPlusInstaller = "$env:USERPROFILE\Desktop\Sandbox-Shared\Softwares\Notepad++\Notepad++.exe"

# ----------------- Install Notepad++ -----------------
If (Test-Path $notepadPlusPlusInstaller) {
    Write-Host "Installing Notepad++..."
    # Install Notepad++ silently
    Start-Process -FilePath $notepadPlusPlusInstaller -ArgumentList "/S" -Wait

    # Define the installed path (standard install location)
    $notepadPlusPlusInstalledPath = "${env:ProgramFiles}\Notepad++\notepad++.exe"
    If (!(Test-Path $notepadPlusPlusInstalledPath)) { 
        $notepadPlusPlusInstalledPath = "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe" 
    }

    If (Test-Path $notepadPlusPlusInstalledPath) {
        # ---- Add 'Edit With Notepad++' and 'Open Notepad++' to context menu -------
        Write-Host "Adding Edit/Open with Notepad++ context menu options"
        
        # File Context Menu
        reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /f
        reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusInstalledPath,0" /f
        # Notepad++ needs the file path to be in quotes. Nested quotes require careful escaping in PowerShell
        reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusInstalledPath`" `"`"%1`"`"" /f
        
        # Directory/Background Context Menu
        reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /ve /d "Open Notepad++" /f
        reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusInstalledPath,0" /f
        reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusInstalledPath`"" /f

        # ---- File Associations (Optional Fallback) ----
        # If you want Notepad++ to handle .txt files by default when classic Notepad isn't overriding it:
        # Check if classic Notepad is NOT set as the handler first (basic check or just overwrite if preferred)
        # Note: Logic to stick with defaults unless needed.
    } else {
        Write-Host "Notepad++ installation failed or file not found in standard paths."
    }
} else {
    Write-Host "Notepad++ installer not found in Shared Folder. Skipping."
}
