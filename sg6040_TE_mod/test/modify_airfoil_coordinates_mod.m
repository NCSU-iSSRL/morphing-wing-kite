files = dir('*.txt');
for q = 1:length(files)
    data = importfile(files(q).name);
    data(:,3) = -1*data(:,2); % y -> z, flip sign
    data(:,2) = 0; % set y to 0 (specific to EXK-02-0025 file)
    writematrix(data, sprintf('Solidworks_mod\\%s', files(q).name), 'Delimiter', 'tab')
end

%% functions
% function sg6040TEmod100c1deg = importfile(filename, dataLines)
% %IMPORTFILE Import data from a text file
% %  SG6040TEMOD100C1DEG = IMPORTFILE(FILENAME) reads data from text file
% %  FILENAME for the default selection.  Returns the numeric data.
% %
% %  SG6040TEMOD100C1DEG = IMPORTFILE(FILE, DATALINES) reads data for the
% %  specified row interval(s) of text file FILENAME. Specify DATALINES as
% %  a positive scalar integer or a N-by-2 array of positive scalar
% %  integers for dis-contiguous row intervals.
% %
% %  Example:
% %  sg6040TEmod100c1deg = importfile("Z:\EXP Kite\EXP Kite\Fowler Flap\sg6040_TE_mod\sg6040_TE_mod_100c_1deg.txt", [1, Inf]);
% %
% %  See also READTABLE.
% %
% % Auto-generated by MATLAB on 08-Jan-2023 13:46:03
% 
% %% Input handling
% 
% % If dataLines is not specified, define defaults
% if nargin < 2
%     dataLines = [1, Inf];
% end
% 
% %% Set up the Import Options and import the data
% opts = delimitedTextImportOptions("NumVariables", 2);
% 
% % Specify range and delimiter
% opts.DataLines = dataLines;
% opts.Delimiter = " ";
% 
% % Specify column names and types
% opts.VariableNames = ["VarName1", "VarName2"];
% opts.VariableTypes = ["double", "double"];
% 
% % Specify file level properties
% opts.ExtraColumnsRule = "ignore";
% opts.EmptyLineRule = "read";
% opts.ConsecutiveDelimitersRule = "join";
% opts.LeadingDelimitersRule = "ignore";
% 
% % Import the data
% sg6040TEmod100c1deg = readtable(filename, opts);
% 
% %% Convert to output type
% sg6040TEmod100c1deg = table2array(sg6040TEmod100c1deg);
% end

function sg6040TEmod115c0deg1 = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  SG6040TEMOD115C0DEG1 = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the numeric data.
%
%  SG6040TEMOD115C0DEG1 = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  sg6040TEmod115c0deg1 = importfile("Z:\EXP Kite\EXP Kite\Fowler Flap\sg6040_TE_mod\test\sg6040_TE_mod_115c_0deg.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 14-Mar-2023 21:02:57

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
sg6040TEmod115c0deg1 = readtable(filename, opts);

%% Convert to output type
sg6040TEmod115c0deg1 = table2array(sg6040TEmod115c0deg1);
end