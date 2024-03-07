clear;clc;
filename = 'morphingData_30-Apr-2023_hour_11.mat';
disp(['Loading data from ', filename])

startTime = 5679.4; % start time for selecting data, sec
endTime = 5704.4; % end time, set to inf to grab all data from startTime to end of file

load(filename); % loads as tscScope

inds = tscScope.tension.Time >= startTime & tscScope.tension.Time <= endTime;
fields = fieldnames(tscScope);

for q = 1:length(fields)
    eval(sprintf('tscMod.%s = timeseries(tscScope.%s.Data(inds), tscScope.%s.Time(inds));', fields{q}, fields{q}, fields{q}));
end

if endTime == inf
    endTime = tscScope.tension.Time(end);
end

tscMod.info = {'Parent file', filename; 'Start time', startTime; 'End time', endTime};

clear tscScope % to avoid accidentally saving wrong variable
disp('Finished')