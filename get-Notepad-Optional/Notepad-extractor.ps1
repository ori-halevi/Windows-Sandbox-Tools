# ----------------- Copy Notepad + all MUI folders -----------------
$sourceNotepad = "$env:WINDIR\System32\notepad.exe"
$destBase = "$env:USERPROFILE\Desktop\Sandbox-Shared\Notepad"

# צור תיקיית יעד
New-Item -ItemType Directory -Force -Path $destBase

# העתק את Notepad עצמו
Copy-Item $sourceNotepad $destBase

# חפש כל תיקיות שפה (לדוגמה en-US, he-IL, fr-FR)
Get-ChildItem "$env:WINDIR" -Directory | Where-Object { $_.Name -match '^[a-z]{2}-[A-Z]{2}$' } | ForEach-Object {
    $muiSource = Join-Path $_.FullName "notepad.exe.mui"
    If (Test-Path $muiSource) {
        $muiDest = Join-Path $destBase $_.Name
        New-Item -ItemType Directory -Force -Path $muiDest
        Copy-Item $muiSource $muiDest
        Write-Host "Copied MUI for language $($_.Name)"
    }
}
