
# =============================== Notepad and Notepad++ Setup ===============================

# If you've included Notepad and/or Notepad++ in the shared folder, set the path to them here. 
# Since notepad isn't included in the sandbox by default.
# If they aren't found, each step will be skipped.

# NotePad Tip: Go to C:\Windows on your main computer and copy Notepad.exe, then copy notepad.exe.mui from your main language folder, such as C:\Windows\en-US
# Important: Notepad.exe.mui can't simply go next to notepad.exe. You need to actually create the language folder (like en-US) again next to notepad.exe and put it in that. Otherwise notepad won't run.

$notepadPath = "$env:USERPROFILE\Desktop\Sandbox-Shared\Notepad\notepad.exe"
# For Notepad++, pointing to the installer
$notepadPlusPlusInstaller = "$env:USERPROFILE\Desktop\Sandbox-Shared\Notepad++\Notepad++.exe"

# ----------------- Check paths -----------------
If (!(Test-Path $notepadPath)) { $notepadPath = $null; Write-Host "Notepad not found, context menu options will not be added." }
If (Test-Path $notepadPlusPlusInstaller) {
    Write-Host "Installing Notepad++..."
    # Install Notepad++ silently
    Start-Process -FilePath $notepadPlusPlusInstaller -ArgumentList "/S" -Wait
}
# Define the installed path (standard install location)
$notepadPlusPlusInstalledPath = "${env:ProgramFiles}\Notepad++\notepad++.exe"
If (!(Test-Path $notepadPlusPlusInstalledPath)) { 
    $notepadPlusPlusInstalledPath = "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe" 
}
If (!(Test-Path $notepadPlusPlusInstalledPath)) {
    $notepadPlusPlusInstalledPath = $null;
    Write-Host "Notepad++ installation failed or file not found in standard paths."
}

# ---- Add 'Edit With Notepad' and 'Open Notepad' to context menu (If Available) -------
If ($null -ne $notepadPath) {
	Write-Host "`nAdding Edit with notepad context menu options"
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad" /f
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad" /v "Icon" /t REG_SZ /d "$notepadPath,0" /f
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad\command" /ve /d "`"$notepadPath`" `"%1`"" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad" /ve /d "Open Notepad" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad" /v "Icon" /t REG_SZ /d "$notepadPath,0" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad\command" /ve /d "`"$notepadPath`"" /f
}

# ---- Add 'Edit With Notepad++' and 'Open Notepad++' to context menu (If Available) -------
If ($null -ne $notepadPlusPlusInstalledPath) {
	Write-Host "`nAdding Edit/Open with Notepad++ context menu options"
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /f
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusInstalledPath,0" /f
	# Notepad++ needs the file path to be in quotes. To get the quotes to show up in registry, need to use two quotes, and need to escape both with powershell `"
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusInstalledPath`" `"`"%1`"`"" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /ve /d "Open Notepad++" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusInstalledPath,0" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusInstalledPath`"" /f
}

# Set .txt files to open with Notepad by default, but register N++ if available
cmd /c assoc .txt=txtfile
If ($null -ne $notepadPath) {
    If (!(Test-Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command')) { New-Item -Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command' -Force }
    # Prefer Standard Notepad for default open
    cmd /c ftype txtfile=`"$notepadPath`" "%1"
} elseif ($null -ne $notepadPlusPlusInstalledPath) {
    # Fallback to Notepad++ if standard Notepad isn't available
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command' -Name '(Default)' -Value ('"{0}" "%1"' -f $notepadPlusPlusInstalledPath) -Type ExpandString -Force
}
