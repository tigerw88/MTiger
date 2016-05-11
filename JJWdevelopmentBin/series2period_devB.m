
%% INPUTS

data = [11 12 13 15 18 19 20 21]; % stub
data = baddata
gap = 1; % stub

%% Main

series = reshape(data,[numel(data) 1]); % force to be n-by-1 column vector


start_id = find([true; diff(series) > gap ]); % indices of breaks in data


a = find([diff(series); inf] > gap );
b = diff([0; a]); % length of the sequences
stop_id = cumsum(b); % endpoints of the sequences

startstop = [series(start_id) series(stop_id)]; % start/stop times paired in n-by-2 matrix

duration = startstop(:,2) - startstop(:,1); % the duration of each start/stop pair
startstop = startstop(setdiff(1:size(startstop,1),find(duration==0)),:); % remove lines in matrix where duration was 0


%% Test Plot

figure, plot(series,1,'sk')
hold on
plot(startstop(:,1),1,'>g')
plot(startstop(:,2),1,'<r')