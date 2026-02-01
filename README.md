# Windows Sandbox Tools – Major Rewrite

This project is a major rewrite of [ThioJoe's Windows Sandbox Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools).  
Many structural changes, improvements, and additional features have been added.  

Original author: ThioJoe  
This fork: Ori Halevi

## 🚀 Quick Start

Getting up and running is effortless.

### 1. Setup
Move the following two items to your **Host Desktop**:
*   `MyDefaultSandbox.wsb` (The configuration file)
*   `Sandbox-Shared` (The entire folder containing scripts)

### 2. Launch
> **💡 First time?** If Windows Sandbox is not yet enabled on your computer, run **`Open-Windows-Features.bat`**, check "Windows Sandbox" in the list, and click OK. You may need to restart your computer. Any time after that, you can safely delete the `.bat` file.

Simply double-click `MyDefaultSandbox.wsb` on your Desktop.
The Windows Sandbox will launch and automatically execute the startup scripts.

### All done - no hassle, just launch! 😊👍

---

##  Repository Structure

*   **`MyDefaultSandbox.wsb`**: The primary configuration file. Maps folders and initiates the setup.
*   **`Sandbox-Shared/`**:
    *   `Scripts/`: Automation scripts (Themes, VC Redist, Winget, and Editor setups).
    *   `Softwares/`:
        *   `Notepad/`: Classic `notepad.exe` files.
        *   `Notepad++/`: `Notepad++.exe` installer here.

---

## 📋 File Reference

### Configuration Files
- **`MyDefaultSandbox.wsb`** - XML configuration file that defines Sandbox settings (12GB RAM, networking, security) and auto-runs scripts on startup
- **`Open-Windows-Features.bat`** - Utility to open the "Windows Features" dialog to enable/disable Windows components like Sandbox

### Scripts/ Directory
- **`SandboxStartup.ps1`** - Main startup script: configures Registry, context menus, file types, Explorer settings, and various system options
- **`Set-Theme-DarkMode.ps1`** - Enables Dark Mode for system and apps + sets wallpaper
- **`Set-Theme-LightMode.ps1`** - Enables Light Mode
- **`Install-VC-Redist.ps1`** - Downloads and installs Visual C++ Redistributables (x86, x64, ARM64)
- **`Install-Winget.ps1`** - Downloads and installs Winget from GitHub (including dependencies) - essential for package management
- **`Install-Microsoft-Store.ps1`** - Installs Microsoft Store in Sandbox
- **`Install-NotepadPlusPlus.ps1`** - Installs Notepad++ from Softwares/Notepad++ folder and adds to context menu
- **`Install-Notepad.ps1`** - Configures classic Notepad (from Softwares/Notepad folder) with context menu integration
