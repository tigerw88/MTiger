function writeRSAM2file( R, directory )
% WRITERSAM2FILE Write data from an RSAM waveform object to a csv file
%
% INPUT
% + R - waveform object containing RSAM data
% + filename - full file path
%

%% run

data = get(R, 'data');

start = get(R, 'start');
intervald = (1/get(R, 'freq'))/60/60/24; % interval in days
interval_min = intervald * 24 * 60;
stop = start+intervald*(numel(data)-1);
dates = (start:intervald:stop)';
% I think the 5 previous lines can all be replaced with dates = get(R, 'timevector')

M = [dates, data];


rsamfilename = [directory datestr(start,'yyyymmdd') '_' num2str(interval_min) 'min' '.csv'];


csvwrite( rsamfilename, M );



