nwb2 = nwbRead('MLD1SessN1.nwb');
t = nwb2.acquisition.get('ElectricalSeries_MA');
t = nwb2.acquisition.get('ElectricalSeries_MA').data.load();
nwb2.general_extracellular_ephys_electrodes.vectordata.get('shortN').data.load(2);



electrodes_object_view = types.untyped.ObjectView( ...
    '/general/extracellular_ephys/electrodes');




electrode_table_region1 = types.hdmf_common.DynamicTableRegion( ...
    'table', electrodes_object_view, ...
    'description', 'some electrodes', ...
    'data', (0:10)');



electrode_table_region2 = types.hdmf_common.DynamicTableRegion( ...
    'table', electrodes_object_view, ...
    'description', 'some different electrodes', ...
    'data', (11:21)');


data = nw.acquisition.get('ElectricalSeries_MI').data.load();
table(transpose(data));
tbl1 = array2table(transpose(data));
stackedplot(tbl1)
