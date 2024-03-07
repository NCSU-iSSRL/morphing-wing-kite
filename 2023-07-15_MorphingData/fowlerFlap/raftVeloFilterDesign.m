clear;clc;
load runTrimmedTraces_total.mat

tscScope = runTrimmedTraces_total{1};
% d = designfilt("lowpassfir", ...
%     PassbandFrequency=0.15,StopbandFrequency=0.2, ...
%     PassbandRipple=1,StopbandAttenuation=60, ...
%     DesignMethod="equiripple");

%filtVel = filtfilt(d,tscScope.raftVelo.Data);
filtVel = movmean(tscScope.raftVelo.Data, 200);

figure(1)
clf
plot(tscScope.raftVelo.Time, tscScope.raftVelo.Data);
hold on
plot(tscScope.raftVelo.Time, filtVel);