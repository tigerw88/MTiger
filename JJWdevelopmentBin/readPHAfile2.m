%% Read AEC catalog data



%% Read file and bring into usable format

clear all
tic

    % open file
fileID = fopen('/Users/jwellik/Documents/JAY-VDAP/AEC/phase_AK_2004.pha');

event = []; % init structure of events
picks = []; % init structure of picks
station.name = ''; % init structure of stations
station.date_time = [];
station.lat = [];
station.lon = [];
station.depth = [];


nevents = 0; % inintially there are 0 events
npicks = 0; % initially there are 0 picks
nstations = 0;
station_list = ''; % an empty string of every station in the file

    % loop over each line in the file
tline = fgetl(fileID);
while ischar(tline)
    
%     disp(tline), pause
        
    if strcmp(tline(1),'#') % if the line is a new event; ie., if the first character is '#'        
   
        nevents = nevents + 1; disp(['Event no.: ' num2str(nevents)])
        
            % reading a new event line
        C = textscan(tline,'%c %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
        date_time = datenum(datestr([C{2} C{3} C{4} C{5} C{6} C{7}],'yyyy-mm-dd HH:MM:SS')); % date_time
        lat = C{8}; % lat
        lon = C{9}; % lon
        depth = C{10}; % depth
%         var11 = C{11};
%         var12 = C{12};
%         var13 = C{13};
%         var14 = C{14};
%         var15 = C{15};
        
        events(nevents).date_time = date_time;
        events(nevents).lat = lat;
        events(nevents).lon = lon;
        events(nevents).depth = depth;
        
    else % else the line is a station pick for the previous event
        
        npicks = npicks + 1; % disp('- Pick added')
        
            % reading a new station pick
        C = textscan(tline,'%s %f %f %s');
        sta = char(C{1}); % station
        var2 = C{2};
        var3 = C{3};
        var4 = C{4};
        
            % put everything into a pick table
        picks{npicks,1}.eventID = nevents;
        picks{npicks,2}.station = sta;
        picks{npicks,3}.date_time = date_time;
        picks{npicks,4}.lat = lat;
        picks{npicks,5}.lon = lon;
        picks{npicks,6}.depth = depth;
        
%         if isempty(structfind(station,'name',sta)) % if the station doesn't exist yet, add it to the list
%             
%             %disp('--added to new station')
%             nstations = nstations + 1;
%             
%             station(nstations).name = sta;
%             station(nstations).date_time = [station(nstations).date_time picks(npicks).date_time];
%             station(nstations).lat = [station(nstations).lat picks(npicks).lat];
%             station(nstations).lon = [station(nstations).lon picks(npicks).lon];
%             station(nstations).depth = [station(nstations).depth picks(npicks).depth];
% 
%                         
%         else
%             
%             %disp('--added to existing station')
% 
%             id = structfind(station,'name',sta);
%             station(id).date_time = [station(nstations).date_time picks(npicks).date_time];
%             station(id).lat = [station(nstations).lat picks(npicks).lat];
%             station(id).lon = [station(nstations).lon picks(npicks).lon];
%             station(id).depth = [station(nstations).depth picks(npicks).depth];
%             
%         end
        
    end
    
    % move to the next line
    tline = fgetl(fileID);

end

fclose(fileID);

clearvars -except events picks station npicks nevents nstations
toc

%% Analyze data for station operation
% 
% t1 = datenum('2004/01/01 00:00:00'); t2 = datenum('2004/12/31 23:59:59');
% date_range = t1:1:t2;
% stations = extractfield(picks,'station');
% date_time = datenum(extractfield(picks,'date_time'));
% 
% 
% for n = 1:length(station_list)
%     
%     current_station = station_list(n)
%     id = find(strcmp(current_station,stations));
%     
% %     s = stations(id);
%     t = datenum(date_time(id));
%     
%     tmp_counts = hist(t,date_range);
%     tmp_working = tmp_counts;
%     tmp_working(tmp_working>0) = 1;
%     
%     counts(n,:) = tmp_counts;
%     working(n,:) = tmp_working;
% 
%     
% end

%% Example plot
% 
% 
% plot(datetime(datestr(date_range)),working,'or'), zoom xon, ylim([0.5 1.5])
% 
% 
