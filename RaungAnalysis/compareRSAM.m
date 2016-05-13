%% compareRSAM

%% Generate RSAM for various stations

% Run the following code:
%   makeRaungRSAM;
% to produce the following mat file:
load('/Users/jaywellik/Dropbox/Indonesia2016_Raung/RSAM.mat')

% ensure everything is the same length and covers the same time
R(1) = RSAM.KBUR; R(2) = RSAM.MLLR; R(3) = RSAM.RAUN; R(4) = RSAM.MLTN; % store as 1-by-n waveform object
R = fix_data_length(R); % fixes length and time coverage

f = 0;

%% Figure - Visualize RSAM 

    % plot rsam for each station in its own subplot
f = f+1; figure(f);
for n = 1:numel(R); ax(n) = subplot(numel(R),1,n); plot(R(n), 'xunit', 'date', 'Color', 'k'); end; zoom('xon'), linkaxes(ax)

%% PLOT RSAM RATIO

for n = 1:numel(R)-1

    % compute ratio - store as waveform object
    RATIO = R(n);
    x1 = get(R(n), 'data');
    x2 = get(R(n+1), 'data');
    ratio = x1 ./ x2;
    ratio(x1 < 1 | isnan(x1)) = 0;
    ratio(x2 < 1 | isnan(x2)) = 0;
    RATIO = set(RATIO, 'data', ratio);
    RATIO = set(RATIO, 'units', 'RSAM ratio');
    RATIO = set(RATIO, 'ChannelTag', '...');
    
    
    % plot figure
    f = f+1; figure(f)
    ax(1) = subplot(211);
    plot(R(n), 'xunit', 'date', 'Color', 'k'); hold on;
    plot(R(n+1), 'xunit', 'date', 'Color', 'r');
    zoom('xon')
    ax(2) = subplot(212);
    plot(RATIO, 'xunit', 'date', 'Color', 'k')
    zoom('xon')
    linkaxes(ax, 'x')
    
end


%%
% 
%     % auto-rename
% KBUR = RSAM.KBUR;
% MLLR = RSAM.MLLR;
% % MLTN = MLTN_rsam_run;
% 
% %%
% 
% % check to make sure RSAM calculations are of the same interval
% % check to make sure RSAM calculations are of the same time period
% % compute ratio
%     % remove nan values from data
% KBUR.data(isnan(KBUR.data)) = 0;
% MLLR.data(isnan(MLLR.data)) = 0;
% RAUN.data(isnan(RAUN.data)) = 0;
% 
%     % KBUR vs. MLLR
%     % compute ratio and plot
% kbur2mllr = KBUR.data ./ MLLR.data;
% 
% f(1) = figure;
% ax(1) = subplot(211);
% plot(KBUR.dnum, KBUR.data, 'k'), hold on
% plot(MLLR.dnum, MLLR.data, 'r')
% datetick('x'), zoom('xon')
% 
% ax(2) = subplot(212);
% plot(KBUR.dnum, kbur2mllr, 'k')
% datetick('x'), zoom('xon')
% linkaxes(ax,'x')
% 
% 
%     % MLLR vs RAUN - co-located
% mllr2raun = MLLR.data ./ RAUN.data;
% 
% f(2) = figure;
% ax(1) = subplot(211);
% plot(MLLR.dnum, MLLR.data, 'k'), hold on
% plot(RAUN.dnum, RAUN.data, 'r')
% datetick('x'), zoom('xon')
% 
% ax(2) = subplot(212);
% plot(MLLR.dnum, mllr2raun, 'k')
% datetick('x'), zoom('xon')
% linkaxes(ax,'x')

