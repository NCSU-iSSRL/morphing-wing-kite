%% 1104
clear;clc;
files = dir('C:\Users\Carson\OneDrive - North Carolina State University\iSSRL\Research\Morphing Wing\2023-07-15_MorphingData\fowlerFlap\morphingDataProfile*.mat');
files2 = dir('C:\Users\Carson\OneDrive - North Carolina State University\iSSRL\Research\Morphing Wing\2023-04-29_MorphingData\selected_data\fowlerFlap_*_elev_*.mat');
for q = 1:length(files2)
    files(end+1, 1) = files2(q,1);
end
runInfoMat_total = [];
runTrimmedTraces_total = {};

for fileNum = 1:length(files)
    load([files(fileNum).folder '\' files(fileNum).name])
    if exist("tscMod", 'var')
        tscScope = tscMod;
        tscScope = rmfield(tscScope, 'info');
        clear tscMod
    end
    tscScope.tension.Data = tscScope.tension.Data/2; % scale tension data by 1/2
    tscScope = rmfield(tscScope, 'clockTime'); % odd logging behavior from this signal; not an important signal; why do all other signals have three samples at t=0??
    tens = tscScope.tension;
    figure(fileNum)
    clf
    plot(tens.Time, tens.Data);
    hold on
    
    startCount = 0; % counting samples above start threshold
    endCount = 0; % counting samples below end threshold
    runStartTime = 0; % time of start of experimental run
    runEndTime = 0; % time of end of exp. run
    lookForEnd = false; % flag set high after start of exp. run
    
    runInfoMat = []; % mat for tracking exp. run info [startTime, endTime, wingProfile, elevatorDefl, avgTens]
    runTrimmedTraces = {}; % array for storing trimmed run timeseries (trimmed between startTime and endTime)
    
    for q = 1:length(tens.Data)
        if (tens.Data(q) > 50) && (startCount < 5) && (tens.Time(q) - runStartTime > 120) % look for five consequtive points > 50 and at least 120 seconds between runs
            startCount = startCount + 1;
        end
        if startCount >= 5 % start of run
            runStartTime = tens.Time(q); % record time of start of test run
            plot(runStartTime, tens.Data(q), 'go')
            startCount = 0; % reset
            lookForEnd = true; % start looking for end threshold
        end
    
        if lookForEnd && (tens.Data(q) < 20) && (endCount < 5) % look for five consequtive points < 50 and have lookForEnd flag high
            endCount = endCount + 1;
        end
        if endCount >= 5 % end of run
            runEndTime = tens.Time(q); % record time of end of run
            plot(runEndTime, tens.Data(q), 'ro')
            endCount = 0; % reset
            lookForEnd = false; % stop looking for end threshold
            
            if (runEndTime - runStartTime >= 15) && (tscScope.aileronBias.Data(q) == 0) % enforce run must be at least 15 seconds and no aileron bias
                runInfoMat(end+1,:) = [runStartTime, runEndTime, tscScope.wingProfile.Data(q), tscScope.servoElevator.Data(q)]; % record run info
            elseif tscScope.aileronBias.Data(q) ~= 0
                plot(runEndTime, tens.Data(q), 'co')
            else
                plot(runEndTime, tens.Data(q), 'ko')
            end
        end
    end
    
    [rows, cols] = size(runInfoMat);
    fields = fieldnames(tscScope); % for use later in generating trimmed timeseries for each run
    
    for q = 1:rows
        timeStartOffset = 3; % seconds, time to wait for transience
        inds = (tens.Time > runInfoMat(q,1) + timeStartOffset) & (tens.Time < runInfoMat(q,2)); % find indices within (startTime+offset) and endTime, bool
        runInfoMat(q, 5) = mean(tens.Data(inds)/2); % record avg tension across run
    
        
        for r = 1:length(fields)
            eval(sprintf('tscTrim.%s = timeseries(tscScope.%s.Data(inds), tscScope.%s.Time(inds));', fields{r}, fields{r}, fields{r}));
        end
    
        runTrimmedTraces{q,1} = tscTrim;
        runTrimmedTraces_total{end+1,1} = runTrimmedTraces{q};
    end
    
    runInfoMat_total(end+1:end+rows, :) = runInfoMat;
    runInfoMat_total(runInfoMat_total(:,3) == 0, 3) = 1000;
end