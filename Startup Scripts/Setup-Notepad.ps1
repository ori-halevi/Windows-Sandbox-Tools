
# =============================== Notepad and Notepad++ Setup ===============================

# If you've included Notepad and/or Notepad++ in the shared folder, set the path to them here. 
# Since notepad isn't included in the sandbox by default.
# If they aren't found, each step will be skipped.

# NotePad Tip: Go to C:\Windows on your main computer and copy Notepad.exe, then copy notepad.exe.mui from your main language folder, such as C:\Windows\en-US
# Important: Notepad.exe.mui can't simply go next to notepad.exe. You need to actually create the language folder (like en-US) again next to notepad.exe and put it in that. Otherwise notepad won't run.

$notepadPath = "C:\Users\WDAGUtilityAccount\Desktop\HostShared\notepad.exe"
# For Notepad++, use the portable version
$notepadPlusPlusPath = "C:\Users\WDAGUtilityAccount\Desktop\HostShared\Notepad++\Notepad++.exe"

# Check if the Notepad and Notepad++ paths exist, if not, set them to null
If (!(Test-Path $notepadPath)) { $notepadPath = $null; Write-Host "Notepad not found, context menu options will not be added." }
If (!(Test-Path $notepadPlusPlusPath)) { $notepadPlusPlusPath = $null; Write-Host "Notepad++ not found, context menu options will not be added." }

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
If ($null -ne $notepadPlusPlusPath) {
	Write-Host "`nAdding Edit/Open with Notepad++ context menu options"
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /f
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusPath,0" /f
	# Notepad++ needs the file path to be in quotes. To get the quotes to show up in registry, need to use two quotes, and need to escape both with powershell `"
	reg add "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusPath`" -settingsDir=`"%appdata%`" `"`"%1`"`"" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /ve /d "Open Notepad++" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++" /v "Icon" /t REG_SZ /d "$notepadPlusPlusPath,0" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad++\command" /ve /t REG_EXPAND_SZ /d "`"$notepadPlusPlusPath`" -settingsDir=`"%appdata%`"" /f
}

# Set .txt files to open with Notepad, or Notepad++ if available
cmd /c assoc .txt=txtfile
If (($null -ne $notepadPath) -or ($null -ne $notepadPlusPlusPath)) {
	If (!(Test-Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command')) { New-Item -Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command' -Force }
	# Prefer Notepad++ if available, otherwise use Notepad
	If ($null -ne $notepadPlusPlusPath) { 
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Classes\txtfile\shell\open\command' -Name '(Default)' -Value ('"{0}" -settingsDir=%appdata% "%1"' -f $notepadPlusPlusPath) -Type ExpandString -Force
	} Else {  # If Npp isn't available, condition above means we know notepadPath is still available
		cmd /c ftype txtfile=`"$notepadPath`" "%1"
	} 
}
