# Arras.io Advanced Auto-Upgrader Macro

An automated macro script written in **AutoHotkey v2.0** designed for **arras.io**. This tool allows users to define a tank evolution sequence and execute it instantly within the game using native inputs.

## Open Source Philosophy

This project is strictly open-source. It can be edited, improved, and redistributed by anyone, provided the resulting code remains entirely open. Restricting access, commercializing, or gatekeeping this software is strictly prohibited under its licensing terms.

## Features

* **Reverse Tree Parser:** Automatically calculates the evolution pathway using the target tank names.
* **Input Emulation:** Utilizes native keystrokes to prevent code injection into the browser environment.
* **High-Precision Timing:** Employs Windows API DLL calls (`QueryPerformanceCounter`) to synchronize keystrokes accurately with server tick rates.
* **Configuration Persistence:** Saves the active tank setup automatically to a local configuration file.

## Usage Instructions

1. Install **AutoHotkey v2.0** on your system.
2. Run the script file.
3. Use the following hotkeys in-game:
   * **F6**: Opens the configuration menu. Input target tank names separated by commas (e.g., `desmos, helix, quadruplex`).
   * **F3**: Toggles the macro execution loop (*Mega-Stacker*) on or off.

## License

This project is licensed under the **GNU General Public License v3.0 (GPLv3)**.

Under this license, you are permitted to:
* Use, modify, and distribute the script.
* **Requirements:** If you modify and redistribute this script, your modified version must also be published as open-source software under the exact same GPLv3 license terms.

---
Maintained by **tiagocunhapereira-br-bootdev537**  
Repository: **ArrasMacro**
