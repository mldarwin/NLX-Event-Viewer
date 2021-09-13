## Purpose / General Information
This SOP walks through the NLX-Event-Viewer apps to process raw microwire and macrowire ephys data from the NLX system. 

###### *Last update: Sept 13 2021*

### Apps
* [NLX_Stage_Select](https://github.com/NERD-CO/NLX-Event-Viewer/tree/main/NLX_Stage_Select): Meta-app to select app (listed below) you would like to use for stage 1, 2 or 3 of processing

* [STAGE1_NLX_EventFinder](https://github.com/NERD-CO/NLX-Event-Viewer/tree/main/STAGE1_NLX_EventFinder): Sort through event files (.nev) to find useable data; creates folder/file structure setup
* [STAGE2_NLX_SessionInspect](https://github.com/NERD-CO/NLX-Event-Viewer/tree/main/STAGE2_NLX_SessionInspect): Split event files into different experiments or epochs

  *Note:* This app is optional and only used if splitting an event file is required
* [STAGE3_NLX_Session2NWB](https://github.com/NERD-CO/NLX-Event-Viewer/tree/main/STAGE3_NLX_Session2NWB): Convert data file into [NWB format](https://www.nwb.org/nwb-neurophysiology/) 

## Stage 1: 
