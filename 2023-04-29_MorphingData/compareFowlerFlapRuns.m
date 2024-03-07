clear;clc;
startFolder = "2023-04-29_MorphingData"; % change this to set your starting folder
folder = strsplit(cd, '\');
if folder{end} ~= startFolder
    disp('Incorrect path. Move to 2023-04-29_MorphingData folder')
    return
end

close all % figures
colors = {'b', 'r', 'k', 'c'};
qColors = 1;
lines = {'.-', 'o-', '*-', '.--'};
qLines = 1;

meanTensionData = [];

generateFigures = true;
saveFigures = true;
wingProfiles = [1000 1004 1154 1304];
elevatorAngles = [5 7 9];

for wingProfile = wingProfiles
    qColors = 1;
    for elevatorAngle = elevatorAngles
        filename = sprintf('fowlerFlap_%4.0d_elev_%02d.mat', wingProfile, elevatorAngle);
        try
            load(filename)
        catch ME
            disp(ME.message)
            continue
        end
        
        data = tscMod.tension.Data;
        dataLabel = 'Tether tension (N)';

        time = tscMod.tension.Time;
        time = time - time(1); % adjust time to start at 0

        newZeroTime = time(data == max(data(time < 5))); % again adjust time so that 0 is the first large peak (when the kite is deployed)
        time = time - newZeroTime(1);
        
        if generateFigures
            % figure of all data
            figure(1)
            legend()
            hold on
            plot(time(time >= 0), data(time >= 0), [colors{qColors}, lines{qLines}], ...
                'DisplayName', sprintf('Wing profile %d, Elevator %d deg.', wingProfile, elevatorAngle))
            xlabel('Time (s)')
            ylabel(dataLabel)
    
            qColors = qColors + 1;
    
            % figure holding elevator angle constant
            figure(elevatorAngle)
            title(sprintf('Constant elevator angle: %d deg.', elevatorAngle))
            legend()
            hold on
            plot(time(time >= 0), data(time >= 0), ...
                'DisplayName', sprintf('Wing profile %d, Elevator %d deg.', wingProfile, elevatorAngle))
            xlabel('Time (s)')
            ylabel(dataLabel)
    %         yyaxis right
    %         plot(time(time >= 3), ones(1,length(time(time >=3))) * mean(data(time >= 3)), ...
    %             'DisplayName', sprintf('Mean tension - Wing profile %d, Elevator %d deg.', wingProfile, elevatorAngle))
    
            % figure holding wing profile constant
            figure(wingProfile)
            camberAngle = mod(wingProfile, 10);
            chordExtension = (wingProfile - camberAngle)/10;
            title(sprintf('Constant wing profile: %d%% chord, %d deg. camber', chordExtension, camberAngle))
            legend()
            hold on
            plot(time(time >= 0), data(time >= 0), ...
                'DisplayName', sprintf('Wing profile %d, Elevator %d deg.', wingProfile, elevatorAngle))
            xlabel('Time (s)')
            ylabel(dataLabel)
        end

        meanTensionData(end+1,:) = [wingProfile, elevatorAngle, mean(data(time >= 3 & time <= 15))];
    end
    qLines = qLines + 1;
end


if generateFigures
    for wingProfile = wingProfiles
        camberAngle = mod(wingProfile, 10);
        chordExtension = (wingProfile - camberAngle)/10;
        figure(2)
        legend()
        hold on
        rowIndices = meanTensionData(:,1) == wingProfile;
        plot(meanTensionData(rowIndices, 2), meanTensionData(rowIndices, 3), 'o--', ...
            'DisplayName', sprintf('%d%% chord, %d deg. camber', chordExtension, camberAngle))
        xlabel('Elevator angle (deg.)')
        ylabel('Mean tether tension (N)')
    end
    xlim([4 10])
end


if saveFigures
    % make new timestamped folder so that figures are not overwritten
    runTimeStamp = datestr(now, 'YYYY_mm_DD_HH_MM_ss');
    folder = sprintf('figures\\%s', runTimeStamp);
    mkdir(folder);
    
    % save figure with data from all runs
    figure(1)
    savefig(sprintf('%s\\allRuns.fig', folder))

    % save mean tension data
    figure(2)
    savefig(sprintf('%s\\meanTension.fig', folder))

    % save constant elevator angle and wing profile figures
    for wingProfile = wingProfiles
        
        if ishandle(wingProfile)
            figure(wingProfile)
            savefig(sprintf('%s\\constantWingProfile_%d.fig', folder, wingProfile))
        end
    end

    for elevatorAngle = elevatorAngles
        if ishandle(elevatorAngle)
            figure(elevatorAngle)
            savefig(sprintf('%s\\constantElevatorAngle_%02d.fig', folder, elevatorAngle))
        end
    end
end