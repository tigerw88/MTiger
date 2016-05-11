%% compareRSAM

%% Generate RSAM for various stations

% Run the following code:
%   makeRaungRSAM;
% to produce the following mat file:
load('/Users/jaywellik/Dropbox/Indonesia2016_Raung/RSAM.mat')

    % auto-rename
KBUR = RSAM.KBUR;
MLLR = RSAM.MLLR;
% MLTN = MLTN_rsam_run;

%%

% check to make sure RSAM calculations are of the same interval
% check to make sure RSAM calculations are of the same time period
% compute ratio
    % remove nan values from data
KBUR.data(isnan(KBUR.data)) = 0;
MLLR.data(isnan(MLLR.data)) = 0;
RAUN.data(isnan(RAUN.data)) = 0;

    % KBUR vs. MLLR
    % compute ratio and plot
kbur2mllr = KBUR.data ./ MLLR.data;

f(1) = figure;
ax(1) = subplot(211);
plot(KBUR.dnum, KBUR.data, 'k'), hold on
plot(MLLR.dnum, MLLR.data, 'r')
datetick('x'), zoom('xon')

ax(2) = subplot(212);
plot(KBUR.dnum, kbur2mllr, 'k')
datetick('x'), zoom('xon')
linkaxes(ax,'x')


    % MLLR vs RAUN - co-located
mllr2raun = MLLR.data ./ RAUN.data;

f(2) = figure;
ax(1) = subplot(211);
plot(MLLR.dnum, MLLR.data, 'k'), hold on
plot(RAUN.dnum, RAUN.data, 'r')
datetick('x'), zoom('xon')

ax(2) = subplot(212);
plot(MLLR.dnum, mllr2raun, 'k')
datetick('x'), zoom('xon')
linkaxes(ax,'x')

