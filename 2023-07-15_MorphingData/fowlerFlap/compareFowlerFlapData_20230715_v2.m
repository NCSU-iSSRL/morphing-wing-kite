clear;clc;
load aggregateData.mat
runs = struct2table(runs);
wingProfiles = unique(runs.wingProfile)';

simFiles = dir('Z:\hydroelastic_model_poolScale\ChordMorphing\SimResults2\results_*_tetherNodes06*.mat');
simFileNames = "";
for q = 1:length(simFiles)
    simFileNames(end+1) = string(simFiles(q).name);
end
simFileNames(1) = [];

figure(61)
clf

% inds = runs.lap1AveV < 0.8;
% runs.lap1AveV(inds) = 0.81;
% runs.lap1AveV(~inds) = 0.75;
% inds = runs.lap2AveV < 0.8;
% runs.lap2AveV(inds) = 0.81;
% runs.lap2AveV(~inds) = 0.75;

plotColors = 'krgbc';
for q = 1:length(wingProfiles)
    %%% experimental
    expResults = [];
    inds = runs.wingProfile == wingProfiles(q) & runs.ailBias == 0; % indices of runs with current wing profile and no aileron bias
    elevDefls = unique(runs.elvDefl(inds))'; % elevator deflections for current wing prof. with no ail bias
    for elev = elevDefls
        runInds = runs.elvDefl == elev & inds; % runs for current elevator deflection and wing profile w/ no ail. bias
        expData = [runs.lap1AveT(runInds)./(runs.lap1AveV(runInds).^2); runs.lap2AveT(runInds)./(runs.lap2AveV(runInds).^2)]/2;
        totalLaps = length(expData);
        expResults(end+1,:) = [elev, mean(expData), std(expData)/sqrt(totalLaps)]; % elevator deflection, mean of data, standard error of data
    end
    errorbar(expResults(:,1), expResults(:,2), expResults(:,3), [plotColors(q)], ...
        'DisplayName', sprintf('Experimental -- Wing profile = %d', wingProfiles(q)))
    hold on

    %%% simulation
    fileInds = contains(simFileNames, num2str(wingProfiles(q)));
    elvDefls = [];
    avgTens = [];
    for r = find(fileInds)
        load([simFiles(r).folder '\' simFiles(r).name]); % loads as results
        elvDefls(end+1:end+length(results.elvDefls)) = results.elvDefls;
        avgTens(end+1:end+length(results.avgT)) = results.avgT ./ 0.75^2;
    end
    [elvDefls, I] = sort(elvDefls); % sorting in ascending order
    avgTens = avgTens(I); % also apply sort to tension mat
    plot(-1*elvDefls, avgTens, [plotColors(q) '.--'], ...
        'DisplayName', sprintf('Simulation -- Wing profile = %d', wingProfiles(q)));
end
grid on
legend()
xlim([-2 3])