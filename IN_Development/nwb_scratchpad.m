nwb2 = nwbRead('MLD1_Session6_raw.nwb');

macroDat = nwb2.acquisition.get('MacroWireSeries').data.load();
adbitVal = nwb2.acquisition.get('MacroWireSeries').data_conversion;
macroDATl = macroDat(:,1); % First channel, all samples
macroDATla = macroDATl*adbitVal;

FS = nwb2.acquisition.get('MacroWireSeries').starting_time_rate;

nwb2.general_extracellular_ephys_electrodes.vectordata.get('shortBAn').data.load(2)




