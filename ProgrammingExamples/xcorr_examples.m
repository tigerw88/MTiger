%% xcorr examples


%% Fictitous vectors
% A very simple example with two very simple vectors

y1 = [0 0 0 0 0 1 2 3 4 5 6 7 8 9];
y2 = [1 2 3 4 5 6 7 8 9 0 0 0 0 0];
interval = 0.01; % interval between samples (e.g., 1/frequency)

vals = xcorr(y1, y2);
lags = -floor(numel(vals)/2)*interval:interval:floor(numel(vals)/2)*interval;

plot(lags, vals, 'k', 'LineWidth', 2);
xlabel('Lag (points)')
ylabel('correlation')

% RESULTS:
%{
The peak correlation value in this example comes at the index of 5 (i.e., 5
* interval). This means that y1 is shifted 5 points ahead of y2. More
generally, this means that a positive correlation value means the first
data series occurs after the second data series. In other words, the first
data series has a positive lag.

%}
