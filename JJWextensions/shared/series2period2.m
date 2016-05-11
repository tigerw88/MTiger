function final = series2periodB( back_windows, data, gap, exclude_include )
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
% NOTE: All of this help needs to be updated. It may not be relevant
% anymore.

%% Parse Inputs

%{
% switch nargin
%     
%     case 2
%         
%         error('This feature is not yet supported.')
%         series = varargin{1}; % series of dates
%         gap = varargin{2}; % required gap value to create break
%         windows(1,1) = series(1); windows(1,2) = series(end);
%         
%     case 3
%         
%         error('This feature is not yet supported.')
%         windows = varargin{1}; % pre-existing definition of periods
%         series = varargin{2}; % series of dates
%         gap = varargin{3}; % required gap value to create break
%         
%     case 4
%         
%         % e.g.,
%         % >> output = series2period(back_windows, baddata, gap, 'exclude')
%         % >> output = series2period(back_windows, good data, gap, 'include')
%         
%         windows = varargin{1}; % pre-existing definition of periods
%         series = reshape(varargin{2},[length(varargin{2}) 1]); % series of dates; confirm as column vector
%         gap = varargin{3}; % required gap value to create break
%         if strcmp(varargin{4},'exclude');
%             exclude = true;
%         elseif strcmp(varargin{4},'include')
%             exclude = false;
%         else
%             error('SERIES2PERIOD did not undertsand your last input. Please use ''exclude'' or ''include''');
%         end
%         
%     otherwise
%         
%         error('SERIES2PERIOD did not understand your input :-(');
%         
% end
%}

%% main

windows = back_windows;
original_series = reshape(data,[numel(data) 1]); % force to be n-by-1 column vector
final = [nan, nan]; % initialize 1-by-2 matrix for output

for n = 1:size(windows,1)
    
    series = original_series(original_series >= windows(n,1) & original_series <= windows(n,2));
    
    if ~isempty(series)
        
        start_id = find([true; diff(series) > gap ]); % indices of breaks in data
        
        
        a = find([diff(series); inf] > gap );
        b = diff([0; a]); % length of the sequences
        stop_id = cumsum(b); % endpoints of the sequences
        
        startstop = [series(start_id) series(stop_id)]; % start/stop times paired in n-by-2 matrix
        
        duration = startstop(:,2) - startstop(:,1); % the duration of each start/stop pair
        startstop = startstop(setdiff(1:size(startstop,1),find(duration==0)),:); % remove lines in matrix where duration was 0
        
        %% This is the part where the the background window is combined with the exclusion windows to yield the study windows
        
        big = windows(n,:);
        small = startstop;
        
        if ~isempty(small)
            
            big = reshape(big,[1 2]); % force reshape to 1-by-2 vector
            small = reshape(small,[numel(small)/2 2]); % force reshape to n-by-2 vector
            
            all = [big; small]; % combine vectors
            
            sorted = sort(reshape(all,[1 numel(all)])); % reshape to single row vector and sort
            
            if ~isempty(sorted) && sorted(1)==sorted(2), sorted = sorted(3:end); end % remove duplicate beginning if start of exclusion window is same as start of background window
            if ~isempty(sorted) && sorted(end-1)==sorted(end), sorted = sorted(1:end-2); end % remove duplicate end if stop of exclusion window is same as stop of background window
            
            starts = sorted(1:2:end);
            stops = sorted(2:2:end);
            
            if numel(starts) > numel(stops), starts = starts(1:end-1); end
            % NOTE: This happens if either the start or the stop (but not both) of the
            % background window was shared with an exclusion window. In this case,
            % disregard the last start time in the list.
            
            new = [starts' stops']; % places start and stop times in pairs stored as n-by-2 matrix
            
            final = [final; new];
            
        else
            
            final = [final; big];
            
            
        end % ~isempty(small)
        
    else
        
        final = [final; windows(n,1) windows(n,2)];
        
    end
    
end

final = final(2:end,:);


%% Test Plot

% figure, plot(series,1,'sk')
% hold on
% plot(startstop(:,1),1,'>g')
% plot(startstop(:,2),1,'<r')

% figure
% plot([back_windows(:,1) back_windows(:,1)],[0 1],'g'), hold on
% plot([back_windows(:,2) back_windows(:,2)],[0 1],'r'), hold on
% 
% plot(original_series,0.525,'sr')
% plot(final(:,1),0.5,'>g');
% plot(final(:,2),0.5,'<r')
% zoom xon









