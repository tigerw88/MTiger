%% Turrialba DLP particle motion

% This is an ugly script, but it's the best way to do it given the way
% other dependency scripts operate.

clear all, close all, clc

%% Set up

start = [datenum('2016/04/11 17:40:00'), ... % just noise
    datenum('2016/04/11 20:00:17'), ... % first candidate event (*JP fav)
    datenum('2016/04/14 20:28:25'), ...
    datenum('20160422012343', 'yyyymmddHHMMSS'), ...
    datenum('20160422150945', 'yyyymmddHHMMSS'), ...
    datenum('20160423005553', 'yyyymmddHHMMSS'), ...
    datenum('20160310194032', 'yyyymmddHHMMSS'), ...
    datenum('2016/04/27 04:19:21'), ... % (*JP fav)
    datenum('20160410071432', 'yyyymmddHHMMSS'), ... % place holder for teleseism
    datenum('20160414233430', 'yyyymmddHHMMSS')]; % % place holder for weird event

tag = ChannelTag({'OV.VIMO.--.HHZ', ... %1
                  'OV.VIMO.--.HHN', ...
                  'OV.VIMO.--.HHE', ...
                  'OV.VICA.--.HHZ', ... %2
                  'OV.VICA.--.HHN', ...
                  'OV.VICA.--.HHE', ...
                  'OV.VTUN.--.HHZ', ... %3
                  'OV.VTUN.--.HHN', ...
                  'OV.VTUN.--.HHE', ...
                  'OV.VTCG.--.HHZ', ... %4
                  'OV.VTCG.--.HHN', ...
                  'OV.VTCG.--.HHE', ...
                  'OV.CTCR.--.HHZ', ... % 5. regional station
                  'OV.CTCR.--.HHN', ...
                  'OV.CTCR.--.HHE', ...
                  'OV.QPSB.--.HHZ', ... % 6. regional station
                  'OV.QPSB.--.HHN', ...
                  'OV.QPSB.--.HHE', ...
                  'OV.JACO.--.HHZ', ... % 6. regional station
                  'OV.JACO.--.HHN', ...
                  'OV.JACO.--.HHE', ...
                  });
fo = filterobject('H', 0.7, 4);              
              

%% Load and Save data

for t = 1:numel(start)
    
    for i = 1:numel(tag)
                    
        raw(i) = irisFetch2wo('waveform', tag(i), start(t), start(t)+60/86400); % (86400 sec/day)
        w(i) = demean(raw(i));
        w(i) = fillgaps(w(i), 0, nan);
        if ~isempty(w(i)), w(i) = filtfilt(fo, w(i)); end
     
    end
    
    Eraw(t,:) = raw;
    E(t,:) = w;
    
end

% save('/Users/jaywellik/Documents/MATLAB/MTiger/Turrialba2016/DLPcandidates.mat', 'Eraw', 'E');

%% Look at events and particle motion


eoi = 7; % event of interest
z_stations = [1:3:numel(tag)];
ehz_stations = 10:12;


linkedplot( E(eoi, z_stations), true )

particleMotion( E(eoi, ehz_stations) )
