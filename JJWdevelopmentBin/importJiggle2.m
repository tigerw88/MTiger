%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Volumes/EFIS_seis/share/jiggle_all_04_13.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/09/25 09:37:38

tic

%% Initialize variables.
% filename = '/Volumes/EFIS_seis/share/jiggle_all_04_13.csv';
filename = '/Users/jaywellik/Downloads/jiggle_all_04_13.txt';
delimiter = {',',''''};
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,15,16,17,23,28,31,32,33,34,36,44]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,2,3,4,5,6,15,16,17,23,28,31,32,33,34,36,44]);
rawCellColumns = raw(:, [7,8,9,10,11,12,13,14,18,19,20,21,22,24,25,26,27,29,30,35,37,38,39,40,41,42,43,45,46,47,48,49,50,51,52,53,54,55,56]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
jiggle.ID = cell2mat(rawNumericColumns(:, 1));
jiggle.EXT_ID = cell2mat(rawNumericColumns(:, 2));
jiggle.DATETIME = cell2mat(rawNumericColumns(:, 3));
jiggle.LAT = cell2mat(rawNumericColumns(:, 4));
jiggle.LON = cell2mat(rawNumericColumns(:, 5));
jiggle.Z = cell2mat(rawNumericColumns(:, 6));
jiggle.HDATUM = rawCellColumns(:, 1);
jiggle.VDATUM = rawCellColumns(:, 2);
jiggle.TYPE = rawCellColumns(:, 3);
jiggle.METHOD = rawCellColumns(:, 4);
jiggle.CM = rawCellColumns(:, 5);
jiggle.VM = rawCellColumns(:, 6);
jiggle.AUTH = rawCellColumns(:, 7);
jiggle.SRC = rawCellColumns(:, 8);
jiggle.GAP = cell2mat(rawNumericColumns(:, 7));
jiggle.DIST = cell2mat(rawNumericColumns(:, 8));
jiggle.RMS = cell2mat(rawNumericColumns(:, 9));
jiggle.ERR_T = rawCellColumns(:, 9);
jiggle.ERR_H = rawCellColumns(:, 10);
jiggle.ERR_Z = rawCellColumns(:, 11);
jiggle.ERR_LAT = rawCellColumns(:, 12);
jiggle.ERR_LON = rawCellColumns(:, 13);
jiggle.OBS = cell2mat(rawNumericColumns(:, 10));
jiggle.USED = rawCellColumns(:, 14);
jiggle.S = rawCellColumns(:, 15);
jiggle.FM = rawCellColumns(:, 16);
jiggle.Q = rawCellColumns(:, 17);
jiggle.V = cell2mat(rawNumericColumns(:, 11));
jiggle.ETYPE = rawCellColumns(:, 18);
jiggle.ST = rawCellColumns(:, 19);
jiggle.ZF = cell2mat(rawNumericColumns(:, 12));
jiggle.HF = cell2mat(rawNumericColumns(:, 13));
jiggle.TF = cell2mat(rawNumericColumns(:, 14));
jiggle.WRECS = cell2mat(rawNumericColumns(:, 15));
jiggle.MAG = rawCellColumns(:, 20);
jiggle.PR = cell2mat(rawNumericColumns(:, 16));
jiggle.MTYP = rawCellColumns(:, 21);
jiggle.MMETH = rawCellColumns(:, 22);
jiggle.COMMENT = rawCellColumns(:, 23);
jiggle.B = rawCellColumns(:, 24);
jiggle.OWHO = rawCellColumns(:, 25);
jiggle.MWHO = rawCellColumns(:, 26);
jiggle.VER = rawCellColumns(:, 27);
jiggle.MOBS = cell2mat(rawNumericColumns(:, 17));
jiggle.MSTA = rawCellColumns(:, 28);
jiggle.AUSE = rawCellColumns(:, 29);
jiggle.Md = rawCellColumns(:, 30);
jiggle.Me = rawCellColumns(:, 31);
jiggle.Ml = rawCellColumns(:, 32);
jiggle.Mw = rawCellColumns(:, 33);
jiggle.MlMd = rawCellColumns(:, 34);
jiggle.MERR = rawCellColumns(:, 35);
jiggle.OAUTH = rawCellColumns(:, 36);
jiggle.VarName54 = rawCellColumns(:, 37);
jiggle.VarName55 = rawCellColumns(:, 38);
jiggle.VarName56 = rawCellColumns(:, 39);


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;

toc