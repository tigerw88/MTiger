%% FFM_HistPlots

% This is to be run after a volcano-specific set-up file.

%% Filter data

    % Filter catalog
catalog_s = filterAnnulus(catalog_s, vlat, vlon, 45); % filter to 45km annulus
catalog_s = filterTime(catalog_s,t1,t2); % filter time period

    % Get earthquake times and adjust for local time
LocalDateTime = datenum(extractfield(catalog_s, 'DateTime')) + time_zone_change; % convert earthquake times to local time zone

%% Display results

     % Print Summary of Results to Command Window
display(' ')
display('Results of ANSS Analysis: ')
display(' ')
display(['Volcano: ' volc_name])
display(['# of events (all types): ' num2str(length(catalog_s))]);
display('# of ''local'' events: ~'); display(' ')
display(['First local event: ' datestr(LocalDateTime(1)) ' ' time_zone_str])
display(['Last local event: ' datestr(LocalDateTime(end)) ' ' time_zone_str]); display(' ')


%% Histogram - Events Per Time-Period

    % compute histograms
dfrac = bin_size;
date_range = t1:dfrac:t2;
all_events_per_time = hist(LocalDateTime, date_range);
cum_all_events_per_time = cumsum(all_events_per_time);


%% Figure Events Per Time

fig_FFM1 = figure;

    % Define y-max & aviation color code plotting parameters
box_bottom = ceil(max(all_events_per_time)*1.02);
box_height = ceil(max(all_events_per_time)*0.02);
y_max = box_bottom+box_height;

    % plot aviation color codes for background
if exist('colorcode','var')
    
    for n = 1:length(colorcode.color)-1
        
        rectangle('Position',[colorcode.timeline(n) box_bottom,...
            colorcode.timeline(n+1)-colorcode.timeline(n) box_height],...
            'FaceColor',colorcode.color{n}); hold on;
        
    end
    rectangle('Position',[colorcode.timeline(end) box_bottom 100 box_height],'FaceColor',colorcode.color{end}); hold on;
    
end

    % plot timeline bars
if exist('timeline','var')
    
    plot([timeline.DateTime timeline.DateTime],[0 box_bottom], 'r', 'LineWidth', 2); hold on;
    
end

    % plot events per time histogram
plot(datetime(datestr(date_range)),all_events_per_time,'k','LineWidth',2), hold on

    % labels for timeline
if exist('timeline','var')
    
        % get y positions for text labels
    ytextpos = smartYTextPosition(length(timeline.comment), box_bottom, 2);
    
        % plot time line labels
    text(timeline.DateTime,ytextpos,timeline.comment,'FontSize',12,'Color','b');
    
end

    % titles, axes, etc.
title({volc_name;['ANSS Catalog Events - Bin Size: ' dayFrac2str(dfrac)]})
ylabel('Event Count')
xlabel(['Time ' time_zone_str])
ylim([0 y_max])
xlim([t1 t2])
zoom xon;

    % Define print properties
fig_FFM1.PaperUnits = 'inches';
fig_FFM1.PaperPosition = [0 0 10 5];
fig_FFM1.PaperPositionMode = 'manual';
saveas(fig_FFM1,[volc_name '_FFM_' dayFrac2str(dfrac)],'fig')
print([volc_name '_FFM_' dayFrac2str(dfrac)],'-dpng')

