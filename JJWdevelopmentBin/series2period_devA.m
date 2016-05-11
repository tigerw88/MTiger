
%% Background windows and Exclusion Windows
% This is what happens when you have dates that define a background window
% and dates that define an exclusion window

% Test Case A
big = [1 11]
small = [1 4; 7 10]
% windows =
%      4     7
%     10    11

% Test Case B
big = [1 11]
small = [2 4; 9 11]
% windows =
%      1     2
%      4     9

% Test Case C
big = [1 9];
small = [1 9];
% windows =
%    Empty matrix: 0-by-2

% Test Case D
big = [1 9]
small = [1 2; 4 5; 7 8]
% windows =
%      2     4
%      5     7
%      8     9

% Test Case E
big = [1 12]
small = [2 4; 6 8; 10 12]
% windows =
%      1     2
%      4     6
%      8    10

% Test Case F
big = [1 12]
small = [2 12];

%%


%%

if ~isempty(small)
    
    big = reshape(big,[1 2]) % force reshape to 1-by-2 vector
    small = reshape(small,[numel(small)/2 2]) % force reshape to n-by-2 vector
    
    all = [big; small] % combine vectors
    
    sorted = sort(reshape(all,[1 numel(all)])) % reshape to single row vector and sort
    
    if ~isempty(sorted) && sorted(1)==sorted(2), sorted = sorted(3:end), end % remove duplicate beginning if start of exclusion window is same as start of background window
    if ~isempty(sorted) && sorted(end-1)==sorted(end), sorted = sorted(1:end-2), end % remove duplicate end if stop of exclusion window is same as stop of background window
    
    starts = sorted(1:2:end)
    stops = sorted(2:2:end)
    
    if numel(starts) > numel(stops), starts = starts(1:end-1), end
    % NOTE: This happens if either the start or the stop (but not both) of the
    % background window was shared with an exclusion window. In this case,
    % disregard the last start time in the list.
    
    windows = [starts' stops']; % places start and stop times in pairs stored as n-by-2 matrix
    
end

windows

