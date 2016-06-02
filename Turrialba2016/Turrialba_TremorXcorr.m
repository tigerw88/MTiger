%% RaungAnalysis - Nov 2012 Tremor xcorrelation
% An attempt to reproduce what Matt Haney did back in 2012
% Analysis of KBUR EHZ and and MLLR EHZ stations
%
% Grab data from local Winston (fill gaps)
% Cross correlate
%
% Jay Wellik, USGS, jwellik at usgs dot gov

%% Set up study parameters

ds = datasource('winston','localhost',16022); % uncomment for local winston
study.start = datenum('2014/11/28 00:00:00');
study.stop = study.start + 1; % study.stop = study.start + d, where d is number of days
study.window = 10/60/24; % xcorrelation window length, days (minutes/60/24 = days)
nslc1 = 'RC.KBUR.--.EHZ';
nslc2 = 'RC.RAUN.--.EHZ';
fo = filterobject('B', [1.5 4.5], 2); % Band pass filter 1-2 Hz with 2 poles

%% Run
%%

clear w1 w2 vals lags lag_vec

t1 = study.start;
idx = 1;

while t1 < study.stop
    
        % initialize data
    w1(idx) = waveform(); w2(idx) = waveform();
        
        % grab data - combine into 1 waveform per channel per time period and fill gaps
    try
%         sprintf('#%d: Grabbing data for %s',idx, datestr(t1))
        w1(idx) = fillgaps(combine(waveform(ds, ChannelTag(nslc1), t1, t1 + study.window)),'interp');
        w2(idx) = fillgaps(combine(waveform(ds, ChannelTag(nslc2), t1, t1 + study.window)),'interp');
    end
    
    
    if isempty(w1(idx)) || isempty(w2(idx))
        
        w1(idx) = waveform(); w2(idx) = waveform();
        
    else
        
            % filter data

        w1f = filtfilt(fo, w1(idx));
        w2f = filtfilt(fo, w2(idx));
        
            % cross-correlate the data
        d1 = get(w1f,'data'); d2 = get(w2f,'data'); % extract y data
        d1 = d1(1:60000); d2 = d2(1:60000); % ensure y data is only n samples long
        [vals(:,idx), the_lags(:,idx)] = xcorr(d1, d2); % compute cross correlation
        
            % complete computations on cross correlated data
        [M(idx), I(idx)] = max(abs(vals(:,idx))); % max absolute value of xcorr signal
        [yupper, ylower] = envelope(vals(:,idx), 10, 'peak'); % upper and lower envelopes of xcorr signal
        peak_envelope(:,1) = max(yupper, abs(ylower)); % absolute value envelope of xcorr signal
        
            % clear tmp variables
        clear d1 d2 yupper ylower w1f w2f
        
    end

    
        % increment variables
    t1 = t1 + study.window;
    idx = idx + 1;
    
    
end

the_lags = the_lags/get(w1(1),'freq');

%% Analyze the cross-correlation of a particular window

% figure(1)
% idx = 1; % choose the window index to plot
% interval = 1/get(w1(1),'freq'); % time in between each sample
% lags  = -floor(numel(vals(:,1))/2)*interval:interval:floor(numel(vals(:,1))/2)*interval; % vector of time lag in seconds
% plot(lags,vals(:,idx), 'k-', 'LineWidth', 1); hold on; % black line for xcorr signal
% plot(lags, peak_envelope(:,idx), 'r-', 'LineWidth', 1); % red line for abs val envelope
% plot(lags(I(idx)), peak_envelope(I(idx)), 'or'); % red dot plotted on abs val envelope corresponding to max abs val xcorr
% xlim([-20 20]) % limit x-axis to reasonable time lags
% zoom xon
% xlabel('Lag (s)')
% ylabel('Cross Correlation')

figure(1);
ax(1) = subplot(211);

    % plot the xcorrelation values as a function of time
imagesc(abs(vals')), colormap jet 

    % subplot axis and plot aesthetics
l = size(vals,1);
nxcorrs = size(vals,2); % number of cross correlations computed
winperhour = 6; % number of xcorr windows per hour;
ax(1).XLim = [(-10/0.01)+ceil(l/2) (10/0.01)+ceil(l/2)];
ax(1).XTickLabels = num2cell((ax(1).XTick-ceil(l/2)) * 0.01);
ax(1).YTick = 0:winperhour*24:nxcorrs; % 1:winperhour:nxcorrs -> tick mark every hour
ax(1).YTickLabels = ax(1).YTick / winperhour / 24; % s/winperhour/24 -> converts index of xcorr window to days
ylabel('Time (days)')
title(sprintf('Cross Correlation(%s, %s) - Starting %s',nslc1, nslc2, datestr(study.start)))

    % stack of all cross correlation vectors
ax(2) = subplot(212);

    % compute necessary information
stack.vals = mean(vals');
[stack.M, stack.I] = max(abs(stack.vals)); % max absolute value of xcorr signal
[yupper, ylower] = envelope(stack.vals, 10, 'peak'); % upper and lower envelopes of xcorr signal
stack.peak_envelope = max(yupper, abs(ylower)); % absolute value envelope of xcorr signal
% interval = 1/get(w1(1),'freq'); % time in between each sample
% lags  = -floor(numel(stack.vals)/2)*interval:interval:floor(numel(vals(:,1))/2)*interval; % vector of time lag in seconds
lags = the_lags(:,1);

    % plot data
plot(lags, stack.vals, 'k-', 'LineWidth', 1); hold on; % black line for xcorr signal
plot(lags, stack.peak_envelope, 'r-', 'LineWidth', 1); % red line for abs val envelope
plot(lags(stack.I), stack.peak_envelope(stack.I), 'or'); % red dot plotted on abs val envelope corresponding to max abs val xcorr

    % subplot axis and plot aesthetics
xlim([-10 10]) % limit x-axis to reasonable time lags
zoom xon
title('Stacked Cross Correlation Vector')
xlabel('Lag (s)')
ylabel('Amplitude (arb.)')


    % show changes in lag over time - maximum xcorr value only
% figure(2);
% max_lag = (I - ceil(size(vals,1)/2)) * interval;
% plot(max_lag, 'k-');


