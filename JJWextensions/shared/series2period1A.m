function final = series2period( varargin )
%SERIES2PERIOD Converts a series of dates to start/stop pairs of each
% period as defined by a given gap value.
% This function has been written to serve one particular purpose and may
% not work outside of that. Clean this up and it could be useful in other
% ways.
% Intended prupose:
%   output = series2period(back_windows, baddata, gap, 'exclude')
%      where you want to exclude bad data days (as definied by a series of
%      dates) from a set of background windows using a given gap to
%      determine when there is a break in data
% SEE ALSO: EXCLUSION2TESTWINDOWS

%% Parse Inputs

switch nargin
    
    case 2
        
        series = varargin{1}; % series of dates
        gap = varargin{2}; % required gap value to create break
        windows(1,1) = series(1); windows(1,2) = series(end);
        
    case 3
        
        windows = varargin{1}; % pre-existing definition of periods
        series = varargin{2}; % series of dates
        gap = varargin{3}; % required gap value to create break
        
    case 4
        
        windows = varargin{1}; % pre-existing definition of periods
        series = varargin{2}; % series of dates
        gap = varargin{3}; % required gap value to create break
        if strcmp(varargin{4},'exclude');
            exclude = true;
        elseif strcmp(varargin{4},'include')
            exclude = false;
        else
            error('SERIES2PERIOD did not undertsand your last input. Please use ''exclude'' or ''include''');
        end
        
    otherwise
        
        error('SERIES2PERIOD did not understand your input :-(');
        
end




%% main

final = [nan, nan];
nwindows = size(final,1);

for n = 1:size(windows,1)
    
    if((series >= windows(n,1) & series <= windows(n,2)))
        
        series1 = [nan; series]; series2 = [series; nan]; % creates two vectors of data that are identical except they are offset by 1 index
        gap_before = series2 - series1; % determines the gap length; the indices are such that the value in 'gap_before' cgives the gap length before that index point in the original data
        id = find(gap_before > gap)'; % indices where there are gaps of significant length
        starts = [series(1); series(id)]; % the starts of each period
        stops = [series(id-1); series(end)]; % the stops of each period
        good_windows = [starts, stops];
        if exclude, good_windows = exclusion2testwindows(windows(n,1),windows(n,2),good_windows); end
        ngoodwindows = size(good_windows,1);
        
        final = [final; good_windows];
        
        nwindows = nwindows + ngoodwindows;
        
    else
        
        nwindows = nwindows + 1;
        final(nwindows,1) = windows(n,1);
        final(nwindows,2) = windows(n,2);
        
    end
    
    
end

final = final(2:end,:);




