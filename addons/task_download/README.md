# Task Download

A simple script that tracks "download" of some data and publishes event on success and failure, that can be used e.g., in Tasks Framework for completing or failing tasks.

## Setup

```SQF
private _downloadTime = 900;
private _downloadSize = 3.42
private _result = [laptop, _downloadTime, _downloadSize] call afmf_task_download_fnc_setup;
```

## Settings

For now there are no CBA Settings, but you can easily change some things via variables below if you'd like a different behaviour.

```SQF
// Display refresh interval. Changing it after setup won't work correctly.
afmf_task_download_displayProgressOnScreenRefreshInterval = 1;
```

_Note that this might be changed at some point to proper CBA Settings._

## Events

_Global events:_

- `afmf_task_download_started`
- `afmf_task_download_paused` **Not implemented**
- `afmf_task_download_resumed` **Not implemented**
- `afmf_task_download_successful`
- `afmf_task_download_failed`

_Server side events:_

- `afmf_task_download_start`

## Authors

- [3Mydlo3](http://github.com/3Mydlo3)
- [Mike](https://github.com/Mike-MF)
- [Jonpas](https://github.com/jonpas)
