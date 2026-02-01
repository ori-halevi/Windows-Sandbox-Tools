# =============================== Notepad Setup ===============================

# If you've included Notepad within the shared folder (extracted from host), set the path here.
# Since notepad isn't included in the sandbox by default.
# If checks fail, these steps are skipped.

# NotePad Tip: Go to C:\Windows on your main computer and copy Notepad.exe (and language folders like en-US/notepad.exe.mui) 
# into the Shared Folder structure properly.

$notepadPath = "$env:USERPROFILE\Desktop\Sandbox-Shared\Notepad\notepad.exe"

# ----------------- Check paths -----------------
If (!(Test-Path $notepadPath)) { 
    $notepadPath = $null; 
    Write-Host "Notepad not found in Sandbox-Shared, context menu options will not be added." 
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

    # Prefer Standard Notepad for default open
    cmd /c ftype txtfile=`"$notepadPath`" "%1"
}
