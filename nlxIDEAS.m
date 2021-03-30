% The Header includes useful information such as type of file, version of Cheetah and type of system used, 
% sampling frequency, input range, filter settings, and ADBitVolts value. The ADBitVolts value is important 
% when importing data into another analysis tool such as MATLAB®. The value indicated is the multiplier used 
% in conjunction with the A/D value stored in each record from each sample. For example:

[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples,...
    Samples, Header] = Nlx2MatCSC('CSC257_0002.ncs', [1 1 1 1 1], 1, 1, [] );

adLine = Header(contains(Header, 'ADBit'));
adItems = strsplit(adLine{1},' ');
adBitVal = str2double(adItems{2});

adbitsVal = adBitVal;
sampleVal = Samples(1);

%%
% (Index 4: Sample4 value= 579) x (ADBitVolt value= 0.000000030518510385491027) =...
%           0.000017670217513199304633 Volts or 17.67 µV

actVolts = sampleVal * adbitsVal; % in Volts
microVolts = actVolts * 1000000;


%% Time conversion

% Start Time in Header File

% Start Recording Value 

% TTL value 


% hdr   = ft_read_header('dataset_directory');
% event = ft_read_event('dataset_directory');
% 
% for i=1:length(event)
%   % the first sample in the datafile is 1
%   event(i).sample = (event(i).timestamp-double(hdr.FirstTimeStamp))./hdr.TimeStampPerSample + 1;
% end