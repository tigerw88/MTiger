%% Read AEC catalog data



%% Read file and bring into usable format
disp('')

clear all
tic

    % open file
fileID = fopen('/Users/jwellik/Documents/JAY-VDAP/AEC/phase_AK_2004.pha');

event = []; % init structure of events
picks = []; % init structure of picks
station.name = ''; % init structure of stations

nevents = 0; % inintially there are 0 events
npicks = 0; % initially there are 0 picks
nstations = 0;
station_list = ''; % an empty string of every station in the file

    % loop over each line in the file
tline = fgetl(fileID);
while ischar(tline)
    
%     disp(tline), pause
        
    if strcmp(tline(1),'#') % if the line is a new event; ie., if the first character is '#'        
   
        nevents = nevents + 1; if rem(nevents,10)==0, disp(['Event no.: ' num2str(nevents)]), end
        
            % reading a new event line
        C = textscan(tline,'%c %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
        events(nevents).date_time = datenum(datestr([C{2} C{3} C{4} C{5} C{6} C{7}],'yyyy-mm-dd HH:MM:SS')); % date_time
        events(nevents).lat = C{8}; % lat
        events(nevents).lon = C{9}; % lon
        events(nevents).depth = C{10}; % depth
%         var11 = C{11};
%         var12 = C{12};
%         var13 = C{13};
%         var14 = C{14};
%         var15 = C{15};
        
    else % else the line is a station pick for the previous event
        
        npicks = npicks + 1; % disp('- Pick added')
        
            % reading a new station pick
        C = textscan(tline,'%s %f %f %s');
        sta = char(C{1}); % station
        var2 = C{2};
        var3 = C{3};
        var4 = C{4};
        
            % put everything into a pick table
        picks(npicks).eventID = nevents;
        picks(npicks).station = sta;
        picks(npicks).date_time = events(nevents).date_time;
        picks(npicks).lat = events(nevents).lat;
        picks(npicks).lon = events(nevents).lon;
        picks(npicks).depth = events(nevents).depth;
        
        if isempty(structfind(station,'name',sta)) % if the station doesn't exist yet, add it to the list
            
            %disp('--added to new station')
            nstations = nstations + 1;
            
            station(nstations).name = sta; disp(['New station added: ' sta ' (' num2str(nstations) ' in database).'])
             
        end
        
    end
    
    % move to the next line
    tline = fgetl(fileID);

end

fclose(fileID);

clearvars -except events picks station npicks nevents nstations
display(['Elapsed time: ' num2str(toc/60) ' minutes.'])
display([num2str(toc)/nevents ' seconds per event.'])


%% Gather all picks for each station
% 
% station.name = ''; % init structure of stations
% station.date_time = [];
% station.lat = [];
% station.lon = [];
% station.depth = [];
% nstations = 0;
% test_l = length(picks);
% 
% tic
% for n = 1:test_l
%     
%     sta = picks(n).station;
%     
%     
%     if isempty(structfind(station,'name',sta));
%         
%         nstations = nstations + 1;
%         station(nstations).name = picks(n).station;
%         station(nstations).date_time = picks(n).date_time;
%         
%     else
%         
%         id = structfind(station,'name',sta);
%         station(id).date_time = [station(id).date_time picks(n).date_time];
%         
%     end
%     
% end
% t2 = toc

%% Gather all picks for each station - version 2
disp('Gathering picks for each station.')

test_l = length(picks);

tic
for n = 1:length(station)
   
   id = structfind(picks,'station',station(n).name); 
   station(n).date_time = extractfield(picks(id),'date_time');
   station(n).lat = extractfield(picks(id),'lat');
   station(n).lon = extractfield(picks(id),'lon');
   station(n).depth = extractfield(picks(id),'depth');
    
end
display(['Elapsed time: ' num2str(toc/60) ' minutes.'])
display([num2str(toc)/nevents ' seconds per event.'])

%% check to make sure everything is good

for n = 1:length(station), a(n) = length(station(n).date_time); end;
if sum(a) == length(picks), disp([num2str(length(picks)) ' of ' num2str(sum(a)) ' records accounted for.']),
    else error(['WARNING! Only ' num2str(length(picks)) ' of ' num2str(sum(a)) ' records accounted for.']); end


%% Histograms and Data On/Off determination
% On/Off is determined on a day-to-day basis
% On = an event was picked at a station that day
disp('Building Histogram and On/Off times for data.')

for n = 1:length(station)
    
   station(n).date_range = floor(station(n).date_time(1)):1:ceil(station(n).date_time(end)); % 1 bin per day for the histogram
   station(n).histogram = hist(station(n).date_time,station(n).date_range); % compute histogram
   station(n).OnOff( station(n).histogram >= 1 ) = 1; % convert histogram to binary yes or no (i.e., has data or not)
   station(n).OnOff( station(n).histogram == 0 ) = 0; % this seems to be necessary if the last histogram data point is zero in order to get histogram and OnOff vectors to be same length
   clear data_range
   
end

disp('Histogram and On/Off times complete.')


save('AECdata','events','picks','station')

%% Figure Plotting
disp('Plotting data.')

f2 = figure

for n = 1:length(station)

    plot(station(n).date_range,station(n).OnOff*n,'sk')
    hold on; clear x y
     
end
x = datetime(datestr(station(end).date_time)); y(1:length(x)) = nan; % only use the datetime var type once to save processing time
plot(x,y)
f2.Children.YTick = 1:length(station);
f2.Children.YTickLabel = extractfield(station,'name');
zoom yon;
title('Station Working Times - Alaska Regional Network')


