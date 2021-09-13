[TS, CN, SF,NumberOfValidSamples, Samples, cscHeader] = Nlx2MatCSC('CSC57.ncs',[1 1 1 1 1], 1, 1, [] );
                                                 
cscHeader                                                 
% 8000 Hz sampling frequency

%% Convert to int16
% cd('D:\NLX_Spike_Microwire_TEMP\2021-03-18_15-07-22')


[Timestamps, EventIDs, TTLs, Extras, EventStrings, evHeader] =...
           Nlx2MatEV('Events.nev', [1 1 1 1 1], 1, 1, [] );

evHeader

%% Downsample to 1K


%% Remove artifacts


%% Detrend


%% Aggregate all 10 channels into a single vector



%% Find the index with the maximal beta peak




%% Plot spectrogram using wavelet function





