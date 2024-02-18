#include "script_component.hpp"
/*
 * Author: Mike, Jonpas from Theseus Mods; 3Mydlo3
 * Only Laptop, Rugged Laptop & PC Set - Screen are actively supported.
 * Has a laptop generate an intel download after an ACE interaction.
 * Will update in increments of 10% until 100. Refresh rate of the download is worked out as downloadTime / 10
 * Texture source is shown on the object via Attributes > Object Specific > Texture #X
 * Can use getVariable on the laptop to check if download is complete with QGVAR(downloadIntel_complete)
 *
 * Further adjusted by 3Mydlo3
 *
 * Arguments:
 * 0: Laptop <OBJECT>
 * 1: Texture Source <NUMBER>
 * 2: Filesize <NUMBER>
 * 3: Download Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 *
 *
 * Public: No
 */

params ["_object", "_textureSource", "_fileSize", "_downloadTime"];

if (!isServer) exitWith {};

private _lastLoginTime = _object getVariable [QGVAR(lastLoginDate), call FUNC(randomDateTime)];
_lastLoginTime params ["_weekDay", "_month", "_day", "_hours", "_minutes", "_seconds"];

private _terminalLogin = " loki login:";
private _terminalPrepare = [
    [
        format ["%1 Ligma", _terminalLogin],
        " Password:",
        "" // replaced with next
    ], [
        format [" Last Login: %1 %2 %3 %4:%5:%6 on ttyl", _weekDay, _month, _day, _hours, _minutes, _seconds],
        " $" // replaced with next
    ], [
        " $ sysinfo",
        "    Ligma@loki",
        "    -----------",
        "    OS: Arch Linux x86_64",
        "    Host: 23475K3 ThinkPad T430",
        "    Kernel: 6.4.8-arch1-1",
        "    Packages: 1277 (pacman)",
        "    Shell: zsh 5.9",
        "    Resolution: 1600x900",
        "    WM: i3",
        "    Theme: Equilux [GTK2/3]",
        "    Icons: Papirus-Dark [GTK2/3]",
        "    Terminal: kitty",
        "    CPU: Intel i5-3320M (4) @ 3.300GHz",
        "    GPU: Intel Graphics Controller",
        "    Memory: 9238MiB / 15258MiB",
        "",
        " $" // replaced with next
    ], [
        " $ mkdir -p /mnt/usb",
        " $" // replaced with next
    ], [
        " $ mount /dev/sdb1 /mnt/usb",
        " $" // replaced with next
    ], [
        " $ /mnt/usb/tyrone.py /home/ligma/confidential --wipe",
        "",
        "     Preparing...",
        "",
        "", // replaced with progress bar
        "",
        "" // replaced with estimated remaining time
    ]
];

private _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminalLogin];
_object setObjectTextureGlobal [_textureSource, _texture];

[FUNC(displayProgressOnScreen), 0.1, [CBA_missionTime, [], _object, _fileSize, _textureSource, GVAR(displayProgressOnScreenRefreshInterval), _terminalPrepare]] call CBA_fnc_addPerFrameHandler;
