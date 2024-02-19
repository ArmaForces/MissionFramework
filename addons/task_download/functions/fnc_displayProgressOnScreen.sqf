#include "script_component.hpp"
/*
 * Author: Mike, Jonpas from Theseus Mods; 3Mydlo3
 * Only Laptop, Rugged Laptop & PC Set - Screen are actively supported.
 * Has a laptop generate an intel download after an ACE interaction.
 * Texture source is shown on the object via Attributes > Object Specific > Texture #X
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
if !(_object getVariable [QGVAR(downloadStarted), false]) exitWith {};

private _prepareFinished = _object getVariable [QGVAR(downloadIntel_prepareFinished_client), false];

// Prepare
if (!_prepareFinished) exitWith {
    // 2s tick rate
    if (_lastTime + PREPARATION_INTERVAL > CBA_missionTime) exitWith {};
    _args set [0, CBA_missionTime];

    private _prepareStage = _object getVariable [QGVAR(downloadIntel_prepareStage_client), 0];

    _terminal deleteAt (count _terminal - 1);
    _terminal append (_terminalPrepare select _prepareStage);

    private _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
    _object setObjectTexture [_textureSource, _texture];
    _object setVariable [QGVAR(downloadIntel_prepareStage_client), _prepareStage + 1];

    if (_prepareStage + 1 >= count _terminalPrepare) then {
        _object setVariable [QGVAR(downloadIntel_prepareFinished_client), true];
    };
};

// Follow wanted download (tick) rate from here
if (_lastTime + _downloadTime > CBA_missionTime) exitWith {};
_args set [0, CBA_missionTime];

// Show download progress
private _downloadStartTime = _object getVariable [QGVAR(downloadStartTime), 0];
private _progressPerTick = _object getVariable [QGVAR(downloadProgressPerTick), MAX_PROGRESS];
private _currentProgress = (CBA_missionTime - _downloadStartTime)/PROGRESS_INTERVAL * _progressPerTick max 0 min MAX_PROGRESS;

private _progressBarStages = floor (_currentProgress / 10);
private _downloaded = _fileSize * (_currentProgress / 100);
private _progressBar = "[          ]";
for "_i" from 1 to _progressBarStages do {
    _progressBar = _progressBar splitString "";
    _progressBar set [_i, "="];
    _progressBar = _progressBar joinString "";
};

private _progressString = format ["     %1GB / %2GB  %3 (%4)\n", _downloaded, _fileSize, _progressBar, [_currentProgress] call FUNC(formatProgress)];
_terminal set [-3, _progressString];

// Set time display
private _totalDownloadTime = _object getVariable [QGVAR(downloadTime), 0];
private _timeText = if (_currentProgress isEqualTo MAX_PROGRESS) then {
    format ["     Download completed in: %1", [_totalDownloadTime] call CBA_fnc_formatElapsedTime]
} else {
    private _estimatedTimeLeft = [_totalDownloadTime, _currentProgress] call FUNC(formatEstimatedTimeRemaining);
    format ["     Estimated time left: %1", _estimatedTimeLeft]
};

_terminal set [-1, _timeText];

_texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
_object setObjectTexture [_textureSource, _texture];

// Finish
if (_currentProgress isEqualTo MAX_PROGRESS) exitWith {
    _handle call CBA_fnc_removePerFrameHandler;

    private _terminalFinal = [
        "     Wiping...",
        "     Remove Device!"
    ];
    _terminal append _terminalFinal;
    _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
    _object setObjectTexture [_textureSource, _texture];

    [{(_this select 0) getVariable [QGVAR(pendriveUnplugged), false]}, {
        params ["_object", "_terminal", "_textureSource"];

        private _terminalDeviceUnplugged = [
            "",
            "     Device unplugged!"
        ];

        _terminal append _terminalDeviceUnplugged;
        _texture = format ['#(rgb,512,512,3)text(0,0,"EtelkaMonospacePro",0.03,"#1A1818","#00B200","%1")', _terminal joinString "\n"];
        _object setObjectTexture [_textureSource, _texture];
    }, [_object, _terminal, _textureSource]] call CBA_fnc_waitUntilAndExecute;
};
