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

private _lastLoginTime = _object getVariable [QGVAR(lastLoginDate), call FUNC(randomDateTime)];
_lastLoginTime params ["_weekDay", "_month", "_day", "_hours", "_minutes", "_seconds"];

private _terminalLogin = " balls login:";
private _terminalPrepare = [
    [
        format ["%1 Ligma", _terminalLogin],
        " Password:",
        "" // replaced with next
    ], [
        format [" Last Login: %1 %2 %3 %4:%5:%6 on ttyl", _weekDay, _month, _day, _hours, _minutes, _seconds],
        " $" // replaced with next
    ], [
        " ligma@balls:~$ ls",
        "    arma3      bateleeye     confidental  free-bpp",
        "    genocides  hypercas      mk-xiv       music",
        "    pictures   special-arma",
        "",
        " ligma@balls:~$" // replaced with next
    ], [
        " ligma@balls:~$ ls confidental/",
        "    accounts.xls  arsenal  embassy        furries",
        "    identities    plans    renchon_nudes  weapons",
        ""
    ], [
        " ligma@balls:~$ mkdir -p /mnt/usb",
        " ligma@balls:~$" // replaced with next
    ], [
        " ligma@balls:~$ mount /dev/sdb1 /mnt/usb",
        " ligma@balls:~$" // replaced with next
    ], [
        " ligma@balls:~$ /mnt/usb/tyrone.py /home/confidential/furries --wipe",
        "",
        "     Preparing...",
        "",
        "" // replaced with next
    ], [
        "", // replaced with progress bar
        "",
        "" // replaced with estimated remaining time
    ]
];

private _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminalLogin];
_object setObjectTexture [_textureSource, _texture];

[FUNC(displayProgressOnScreen), 0.1, [CBA_missionTime, [], _object, _fileSize, _textureSource, GVAR(displayProgressOnScreenRefreshInterval), _terminalPrepare]] call CBA_fnc_addPerFrameHandler;
