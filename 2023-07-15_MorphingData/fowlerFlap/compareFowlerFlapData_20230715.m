clear;clc;
load runInfoMat_total.mat % [startTime, endTime, wingProfile, elevatorDefl, avgTens]
load runTrimmedTraces_total.mat
simFiles = dir('Z:\hydroelastic_model_poolScale\ChordMorphing\SimResults2\results_*_tetherNodes06*.mat');
simFileNames = "";
for q = 1:length(simFiles)
    simFileNames(end+1) = string(simFiles(q).name);
end
simFileNames(1) = [];

for q = 1:length(runInfoMat_total)
    tscScope = runTrimmedTraces_total{q};
    filteredVelo = movmean(tscScope.raftVelo.Data, 100);
    veloNormalizedTens = tscScope.tension.Data ./ (filteredVelo .^ 2);
    if mean(veloNormalizedTens) > 1e10 % resultant of no string pot data
        veloNormalizedTens = tscScope.tension.Data ./ 0.75^2;
    end
    runInfoMat_total(q,6) = mean(veloNormalizedTens)/2;
end

figure(6)
clf
wingProfiles = unique(runInfoMat_total(:,3));
plotColors = 'rgbkc';

for q = 1:length(wingProfiles)
    inds = runInfoMat_total(:,3) == wingProfiles(q);
%     plot(runInfoMat_total(inds, 4), runInfoMat_total(inds, 6), [plotColors(q) '*'], ...
%         'DisplayName', sprintf('Experiment -- Wing profile = %d', wingProfiles(q)));
    hold on
    
    fileInds = contains(simFileNames, num2str(wingProfiles(q)));
    
    elvDefls = [];
    avgTens = [];
    for r = find(fileInds)
        load([simFiles(r).folder '\' simFiles(r).name]); % loads as results
        elvDefls(end+1:end+length(results.elvDefls)) = results.elvDefls;
        avgTens(end+1:end+length(results.avgT)) = results.avgT;% ./ 0.75^2;
    end
    [elvDefls, I] = sort(elvDefls); % sorting in ascending order
    avgTens = avgTens(I); % also apply sort to tension mat
    plot(-1*elvDefls, avgTens, [plotColors(q) '.--'], ...
        'DisplayName', sprintf('Simulation -- Wing profile = %d', wingProfiles(q)));

    elevDefls = unique(runInfoMat_total(inds, 4));
    errorBarData = [];
    for r = 1:length(elevDefls)
%         plot(elevDefls(r), mean(runInfoMat_total(inds & runInfoMat_total(:,4) == elevDefls(r), 6)), [plotColors(q) '*'], ...
%             'DisplayName', sprintf('Wing profile = %d', wingProfiles(q)));
        testData = runInfoMat_total(inds & runInfoMat_total(:,4) == elevDefls(r), 6);
        errorBarData(end+1,:) = [elevDefls(r), mean(testData), std(testData)]; % elev defl, mean of test data, standard dev. of test data
    end
    errorbar(errorBarData(:,1), errorBarData(:,2), errorBarData(:,3), [plotColors(q)], ...
        'DisplayName', sprintf('Experimental -- Wing profile = %d', wingProfiles(q)))
end
legend()
xlabel('Elevator deflection (deg.)')
ylabel('Velocity normalized average run tension (Ns^2/m^2)')

%%% if velocity is > 0.8, the tension is normalized by 0.81 m/s, otherwise 0.75