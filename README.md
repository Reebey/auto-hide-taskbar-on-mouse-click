# AutoHideTaskbar

A lightweight AutoHotkey script that automatically hides the Windows taskbar and shows it only when you intentionally click at the very bottom of the screen.

If you ever got annoyed by the taskbar popping up unexpectedly and interrupting your workflow, this tool is for you.



> _Note: This script was written with the Windows taskbar auto-hide option enabled.
> 
---

## Features

- Automatically hides the taskbar after a configurable delay.
- Shows the taskbar only when you click at the very bottom edge of the screen.
- Minimal resource usage thanks to periodic mouse checks.

---

## Installation

1. Install [AutoHotkey v2.0](https://www.autohotkey.com/)
2. Download the `AutoHideTaskbar.ahk` script.
3. Run the script by double-clicking it.

---

## Running on system startup (Windows)

To have the script run automatically when you start Windows:

1. Press `Win + R`, type `shell:startup`, and press Enter. This opens the Startup folder.
2. Create a shortcut to the `AutoHideTaskbar.ahk` script inside this folder.
3. Alternatively, compile the script to an `.exe` and place the executable shortcut there.

The script will now run in the background every time you log in.

---

## Configuration

- `TaskbarHideDelay`: Time in milliseconds before the taskbar is hidden after mouse leaves it.
- `MouseCheckInterval`: How often (in ms) the script checks mouse position.
- `IsAtBottomThreshold`: Sensitivity for the bottom screen click to show the taskbar.

Modify these parameters directly inside the script.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
