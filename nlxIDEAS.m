% The Header includes useful information such as type of file, version of Cheetah and type of system used, 
% sampling frequency, input range, filter settings, and ADBitVolts value. The ADBitVolts value is important 
% when importing data into another analysis tool such as MATLAB®. The value indicated is the multiplier used 
% in conjunction with the A/D value stored in each record from each sample. For example:

[TimestampsCSC, ChannelNumbers, SampleFrequencies, NumberOfValidSamples,...
    Samples, HeaderCSC] = Nlx2MatCSC('CSC257_0019.ncs', [1 1 1 1 1], 1, 1, [] );

adLine = HeaderCSC(contains(HeaderCSC, 'ADBit'));
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
[TimestampsEV, EventIDs, TTLs, Extras, EventStrings, HeaderEV] =...
Nlx2MatEV('Events_0030.nev', [1 1 1 1 1], 1, 1, [] );
% Start Time in Header File

% FIND matching time create
timeCline = HeaderEV(contains(HeaderEV, '-TimeCreated'));
tcItems = strsplit(timeCline{1},' ');
timeCreate = datetime([tcItems{2} , ' ', tcItems{3}],...
    'InputFormat','yyyy/MM/dd HH:mm:ss');

% Start Recording Value 
allStarts = contains(EventStrings,'Starting Recording');
singStart = find(allStarts,1,'last');
% TTL value 
ttlVal = TimestampsEV(singStart);
% Time in Seconds
% timeSecs = timeCreate + (

% Sample?
%%
TimestampsCSCm = zeros(512,size(TimestampsCSC,2));
TimestampsCSCm(1,:) = TimestampsCSC;
for ti = 1:size(TimestampsCSC,2)
    
    if ti == size(TimestampsCSC,2)
        tmpl = linspace(TimestampsCSC(ti),TimestampsCSC(ti)+16000,511);
    else
        tmpl = linspace(TimestampsCSC(ti),TimestampsCSC(ti + 1),511);
    end
    tmplt = transpose(tmpl);
    TimestampsCSCm(2:512,ti) = tmpl;
end

%%
ttlVal = TimestampsEV(4);
sv = abs(TimestampsCSCm - ttlVal);
[~ , ephysInd] = min(min(sv));

%% 
timeREcord = datetime(ttlVal/1000000,'ConvertFrom','posixtime','TimeZone','America/Denver');





% hdr   = ft_read_header('dataset_directory');
% event = ft_read_event('dataset_directory');
% 
% for i=1:length(event)
%   % the first sample in the datafile is 1
%   event(i).sample = (event(i).timestamp-double(hdr.FirstTimeStamp))./hdr.TimeStampPerSample + 1;
% end