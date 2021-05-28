% Go to Event Directory
cd('D:\nwbPROCESS_work\MW2\EVENTs')

% load Session file
load('D:\nwbPROCESS_work\MW2\SESSIONs\allSessionData.mat','saveSessAll');

%% Check how the event time stamps are related in the last to Sessions

clc
for i = 1:length(saveSessAll)
    
    realTIME = datetime(saveSessAll{i}.StartTime/1000000,'ConvertFrom',...
        'posixtime','TimeZone','America/Denver');
    
    disp(realTIME);
    
end

%%

clc

for ii = 1:length(saveSessAll)
    tmpEV = saveSessAll{ii}.SessionInfo.header{6}(33:end);
    disp(tmpEV)
end

%%
cscRepoT = dir('*.ncs');
cscRepo = {cscRepoT.name};

fileEls = cellfun(@(x) strsplit(x, {'_','.'}), cscRepo, 'UniformOutput',false);

cscAllnum = cellfun(@(x) x{1}, fileEls , 'UniformOutput',false);

uniCSC = unique(cscAllnum);
useCSC = uniCSC(1);

allCSCns = transpose(cscRepo(ismember(cscAllnum,useCSC)));
%%
clc
for ai = 1:length(allCSCns)
    [ts, ~, ~, ~,...
        ~, ~] = Nlx2MatCSC(allCSCns{ai}, [1 1 1 1 1], 1, 1, [] );
    
    tsONE = ts(1);
    
    realTIME = datetime(tsONE/1000000,'ConvertFrom',...
        'posixtime','TimeZone','America/Denver');
    disp(allCSCns{ai})
    disp(realTIME)
    
end


%%
clc
ts1 = datetime(saveSessAll{7}.StartTime/1000000,'ConvertFrom',...
    'posixtime','TimeZone','America/Denver');
disp(ts1)
ts2 = datetime(saveSessAll{8}.StartTime/1000000,'ConvertFrom',...
    'posixtime','TimeZone','America/Denver');
disp(ts2)
ts3 = datetime(saveSessAll{8}.StopTime/1000000,'ConvertFrom',...
    'posixtime','TimeZone','America/Denver');
disp(ts3)

%%
% CSC1_0010.ncs

[ts, ~, ~, ~,...
    samples, ~] = Nlx2MatCSC(allCSCns{12}, [1 1 1 1 1], 1, 1, [] );

realTIME = datetime(ts/1000000,'ConvertFrom',...
    'posixtime','TimeZone','America/Denver');


%%
uniCSC11 = cellfun(@(x) [x,'_0011.ncs'],uniCSC,'UniformOutput',false);
for t = 1:length(uniCSC11)
    
    [ts, ~, ~, ~,...
    ~, ~] = Nlx2MatCSC(allCSCns{12}, [1 1 1 1 1], 1, 1, [] );
    disp(numel(ts))
    
    
end



%%
% Locate unique CSC extension files (i.e, CSC1__001, __002)
cscRepoT = dir('*.ncs');
cscRepo = {cscRepoT.name};

fileEls = cellfun(@(x) strsplit(x, {'_','.'}), cscRepo, 'UniformOutput',false);

cscAllnum = cellfun(@(x) x{1}, fileEls , 'UniformOutput',false);

uniCSC = unique(cscAllnum);
useCSC = uniCSC(1);

allCSCns = transpose(cscRepo(ismember(cscAllnum,useCSC)));
%%
timeSTAMP = saveSessAll{8}.SessionInfo.ts(saveSessAll{1}.StartIndex);

% Loop through all extension

%%
micAll = zeros(size(allCSCns));
ephInd = zeros(size(allCSCns));
for ci = 1:length(allCSCns)
    disp(allCSCns{ci})
    [timeVEC, ~, ~, ~,...
        ~, ~] = Nlx2MatCSC(allCSCns{ci}, [1 1 1 1 1], 1, 1, [] );
    
    % Create interpolation
    
    
    timeMAT = zeros(512,size(timeVEC,2));
    timeMAT(1,:) = timeVEC;
    for ti = 1:size(timeVEC,2)
        
        if ti == size(timeVEC,2)
            tmpl = linspace(timeVEC(ti),timeVEC(ti)+16000,511);
        else
            tmpl = linspace(timeVEC(ti),timeVEC(ti + 1),511);
        end
        tmplt = transpose(tmpl);
        timeMAT(2:512,ti) = tmplt;
    end
    
    % Create a table with the time difference between nearest value
    % and timestamp
    offSETtime = abs(timeVEC - timeSTAMP);
    [micOffset , ephysInd] = min(min(offSETtime));
    
    micAll(ci) = micOffset;
    ephInd(ci) = ephysInd;
    
end

%%
% Output CSC duplicate with the lowest value
chckTable = table(allCSCns,micAll,ephInd);
chckTable.msAll = chckTable.micAll/(1e+6);

[~ , minREC] = min(chckTable.micAll);

foundCSC = chckTable.allCSCns{minREC};
timeDIF = chckTable.msAll(minREC);