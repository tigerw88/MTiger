%% Kasatochi2008.m

    % Initialize Volcano Settings
volc_name = 'Kasatochi';
vlat = 52.1693; vlon = -175.5113;
% ??; % timeline information
time_zone_str = 'AKDT (UTC -8h)';
time_zone_change = -8/24;
 
    % set time window for analysis
t1 = datenum('2008/07/01 00:00:00');
t2 = datenum('2008/08/15 23:59:59');

    % Load time-line
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Kasatochi2008/kasatochiAKDT.mat')
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Kasatochi2008/kasatochiAKDT-aviation.mat')
% timeline.comment = comment; clear comment;
% timeline.DateTime = DateTime; clear DateTime;
% timeline.DateTime = datenum(timeline.DateTime,'yyyy-mm-dd_HH:MM:SS'); % Kasatochi specific data parsing

    % load ANSS catalog
load('catsearch.20704.mat')
catalog_s = catalog; % initialize subcatalog

    % Filter catalog
catalog_s = filterAnnulus(catalog_s, vlat, vlon, 45); % filter to 45km annulus
catalog_s = filterTime(catalog_s,t1,t2); % filter time period

    % Get earthquake times and adjust for local time
DateTime = datenum(extractfield(catalog_s, 'DateTime')) + time_zone_change; % convert earthquake times to local time zone

     % Print Summary of Results to Command Window
display(' ')
display('Results of ANSS Analysis: ')
display(' ')
display(['Volcano: ' volc_name])
display(['# of events (all types): ' num2str(length(catalog_s))]);
display('# of ''local'' events: ~'); display(' ')
display(['First local event: ' datestr(DateTime(1)) ' ' time_zone_str])
display(['Last local event: ' datestr(DateTime(end)) ' ' time_zone_str]); display(' ')


%% Histogram - Events Per Time-Period

    % compute histograms
dfrac = 1/24;
date_range = t1:dfrac:t2;
all_events_per_time = hist(DateTime, date_range);


%% 

figure

    % Define y-max
y_max = max(all_events_per_time)+2;

    % plot aviation color codes for background
rectangle('Position',[colorcode.timeline(1) y_max-1 colorcode.timeline(2)-colorcode.timeline(1) 1],'FaceColor',colorcode.color{1}); hold on;   
rectangle('Position',[colorcode.timeline(2) y_max-1 colorcode.timeline(3)-colorcode.timeline(2) 1],'FaceColor',colorcode.color{2}); hold on;
rectangle('Position',[colorcode.timeline(3) y_max-1 colorcode.timeline(4)-colorcode.timeline(3) 1],'FaceColor',colorcode.color{3}); hold on;
rectangle('Position',[colorcode.timeline(4) y_max-1 100 1],'FaceColor',colorcode.color{4}); hold on;

    % plot events per time histogram
plot(datetime(datestr(date_range)),all_events_per_time,'k','LineWidth',2), hold on

    % timeline information
plot([timeline.DateTime timeline.DateTime],[0 y_max-1], 'r', 'LineWidth', 2); hold on;
ytextpos = [y_max*1/9 y_max*3/9 y_max*5/9 y_max*7/9 y_max*2/9,...
            y_max*4/9, y_max*6/9, y_max*8/9, y_max*1/9];
text(timeline.DateTime,ytextpos,timeline.comment,'FontSize',12,'Color','b');       


title({'Kasatochi 2008 Eruption Sequence';'ANSS Catalog Events - Bin Size: 1 hour'})
ylabel('Event Count')
xlabel(['Time ' time_zone_str])
ylim([0 y_max])
xlim([t1 t2])
zoom xon;







