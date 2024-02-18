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
 * 0: PFH Args <ARRAY>
 *  0: Last refresh time <NUMBER>
 *  1: Current terminal content <ARRAY>
 *  2: Object used for download <OBJECT>
 *  3: Total file size (in GB) to download <NUMBER>
 *  4: Download tick rate <NUMBER>
 *  5: Pending terminal prepare steps <ARRAY>
 * 1: PFH Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_args", "_handle"];
_args params ["_lastTime", "_terminal", "_object", "_fileSize", "_textureSource", "_downloadTime", "_terminalPrepare"];

// Exit if download hasn't yet started
if !(_object getVariable [QGVAR(downloadIntel_active), false]) exitWith {};

private _stage = _object getVariable [QGVAR(downloadIntel_stage), -1];

// Prepare
if (_stage < 0) exitWith {
    // 2s tick rate
    if (_lastTime + 2 > CBA_missionTime) exitWith {};
    _args set [0, CBA_missionTime];

    private _prepareStage = _object getVariable [QGVAR(downloadIntel_prepareStage), 0];

    _terminal deleteAt (count _terminal - 1);
    _terminal append (_terminalPrepare select _prepareStage);

    private _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
    _object setObjectTextureGlobal [_textureSource, _texture];
    _object setVariable [QGVAR(downloadIntel_prepareStage), _prepareStage + 1];

    if (_prepareStage + 1 >= count _terminalPrepare) then {
        _object setVariable [QGVAR(downloadIntel_stage), _stage + 1];
    };
};

// Follow wanted download (tick) rate from here
if (_lastTime + _downloadTime > CBA_missionTime) exitWith {};
_args set [0, CBA_missionTime];

// Download
private _progress = _object getVariable [QGVAR(progress), 0];
private _progressBarStages = floor (_progress / 10);
private _downloaded = _fileSize * (_progress / 100);
private _progressBar = "[          ]";
for "_i" from 1 to _progressBarStages do {
    _progressBar = _progressBar splitString "";
    _progressBar set [_i, "="];
    _progressBar = _progressBar joinString "";
};

private _progressString = format ["     %1GB / %2GB  %3 (%4)\n", _downloaded, _fileSize, _progressBar, [_progress] call FUNC(formatProgress)];
_terminal set [-3, _progressString];

private _totalTime = _object getVariable [QGVAR(downloadTime), 0];
private _estimatedTimeLeft = [_totalTime, _progress] call FUNC(calculateEstimatedTimeRemaining);
private _estimatedTimeLeftText = format ["     Estimated time left: %1", _estimatedTimeLeft];
_terminal set [-1, _estimatedTimeLeftText];

_texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
_object setObjectTextureGlobal [_textureSource, _texture];
_object setVariable [QGVAR(downloadIntel_stage), _stage + 1];

// Finish
if (_progress isEqualTo MAX_PROGRESS) exitWith {
    _handle call CBA_fnc_removePerFrameHandler;

    private _terminalFinal = [
        "     Completed",
        "     Wiping...",
        "     Remove Device!"
    ];
    _terminal append _terminalFinal;
    _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
    _object setObjectTextureGlobal [_textureSource, _texture];
    _object setVariable [QGVAR(downloadIntel_complete), true, true];
};
