# Windows Sandbox Tools

A streamlined and professional collection of tools designed to enhance and automate your Windows Sandbox environment.

## 🚀 Quick Start

Getting up and running is effortless.

### 1. Setup
Move the following two items to your **Host Desktop**:
*   `MyDefaultSandbox.wsb` (The configuration file)
*   `Sandbox-Shared` (The entire folder containing scripts)

### 2. Launch
Simply double-click `MyDefaultSandbox.wsb` on your Desktop.
The Windows Sandbox will launch and automatically execute the startup scripts.

### All done - no hassle, just launch! 😊👍

---

## 📝 Optional Features

### Enable Classic Notepad
By default, the Windows Sandbox does not include basic Notepad. To enable it:
1.  Navigate to: `get-Notepad-Optional` folder.
2.  Run: `Run-get-Notepad.bat` (This extracts Notepad from your host system).
The next time you launch the Sandbox, Classic Notepad will be available and integrated into the right-click menu.

---

## 📂 Repository Structure

*   **`MyDefaultSandbox.wsb`**: The primary configuration file. Maps folders and initiates the setup.
*   **`Sandbox-Shared/`**:
    *   `Scripts/`: Automation scripts (Themes, VC Redist, Winget, and Editor setups).
    *   `Notepad++/`: `Notepad++.exe` installer here.
*   **`get-Notepad-Optional/`**: Utility to extract the classic `notepad.exe` and its localization files from your host.
