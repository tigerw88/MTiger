%% Mount St. Helens 2004 (Time Zone: DPT (UTC-7hrs)

    % load ANSS catalog
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/MSH2004/ANSScatalog_MSH_20040801-20041130.mat')
catalog_s = catalog; % initialize subcatalog
DateTime = extractfield(catalog_s, 'DateTime') - 7/24; % convert earthquake times to PDT

    % Initialize Volcano Settings
volc_name = 'Mount St. Helens';    
vlat = 46.2; vlon = -122.18; % Mount St. Helens coordinates (GVP)
mountsthelens2004; % timeline information
time_zone_str = 'PDT (UTC-7h)';

    % Filter to 45km annulus
catalog_s = filterAnnulus(catalog_s, vlat, vlon, 45);

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

    % adjust dates, if necessary
t1 = DateTime(1);
t2 = DateTime(end);

    % compute histograms
dfrac = 1/24;
date_range = t1:dfrac:t2;
all_events_per_day = hist(DateTime, date_range);


%% Figure - Daily Event Counts and Cumulative

figure

    % Define y-max
y_max = max(all_events_per_day)+2;

    % MSH SPECIFIC - Time Periods of Dominant Activity
rectangle('Position',[datenum('2004/09/23') 0 2 y_max],'EdgeColor','b','LineWidth',2,'FaceColor',[0.4 0.4 0.4]); hold on;
rectangle('Position',[datenum('2004/09/25') 0 3 y_max],'EdgeColor','b','LineWidth',2,'FaceColor',[0.6 0.6 0.6])
rectangle('Position',[datenum('2004/09/28') 0 30 y_max],'EdgeColor','b','LineWidth',2,'FaceColor',[0.8 0.8 0.8])
text(datenum('2004/09/23')+0.25,16,'VT','FontSize',12,'Color','b');
text(datenum('2004/09/25')+0.25,16,'VT, LF, Hy','FontSize',12,'Color','b');
text(datenum('2004/09/28')+0.25,16,'LF & Hy','FontSize',12,'Color','b');


    % plot events per time histogram
plot(datetime(datestr(date_range)),all_events_per_day,'k','LineWidth',2), hold on

plot([msh2004.time msh2004.time],[0 y_max],'r','LineWidth',2); hold on;
ytextpos = [15 13 11];
text(datenum(msh2004.time),ytextpos,msh2004.txt,'FontSize',12,'Color','b');
title({'Mount St. Helens 2004 Eruption Sequence';'ANSS Catalog Events - Bin Size: 1 hour'})
ylabel('Event Count')
xlabel(['Time ' time_zone_str])
ylim([0 y_max])
xlim([datenum('2004/09/21') datenum('2004/10/27')])
zoom xon;






