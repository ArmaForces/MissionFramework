# Task Download

A simple script that tracks "download" of some data and publishes event on success and failure, that can be used e.g., in Tasks Framework for completing or failing tasks.

## Setup

```SQF
private _result = [laptop] call afmf_task_download_fnc_setup;
```

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
