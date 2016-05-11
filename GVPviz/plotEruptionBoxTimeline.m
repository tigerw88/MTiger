%% plotEruptionBoxTimeline

searchForRaungAnalogs

%% Chose Volcano

% start = RAUNG.ERUPTIONS.StartDatenum;
% stop = RAUNG.ERUPTIONS.EndDatenum;
% vei = RAUNG.ERUPTIONS.VEI_max;

start = IJEN.ERUPTIONS.StartDatenum;
stop = IJEN.ERUPTIONS.EndDatenum;
vei = IJEN.ERUPTIONS.VEI_max;

%%

    % make minimum length n days
min_plot_dur = 90; % days
I = find(isnan(stop)); stop(I) = start(I) + min_plot_dur; % if no stop is given, set to 30 days
I = (stop-start) < min_plot_dur; stop(I) = start(I) + min_plot_dur; % if duration is less than 30, increase to 30 days

    % limit to certain time range
I = find(start > datenum(1950,0,0));
start = start(I); stop = stop(I); vei = vei(I);

    % define start and stop of plot
startdv = datevec(start(1));
stopdv = datevec(start(end));
startyr = startdv(1); % first year in the series
stopyear = stopdv(1); % last year in the series
axyr1 = startyr - rem(startyr,10); % first year for x-axis (rounded down to beginning of decade)
years = axyr1:10:stopyear; % years (double) for the x-axis
yearsdn = datenum(years,0,0); % years (datenum) for the x-axis

f = figure; 
for n = 1:length(start)
    
    if (vei(n) == 4);
        color = [1 0.5 0];
    elseif (vei(n) == 3);
        color = [1 1 0];
    elseif (vei(n) == 2)
        color = [0 0.8 0];
    elseif (vei(n) == 1)
        color = [0 0 0.8];
    elseif (vei(n) == 0);
        color = [0.5 0.5 0.5];
    else
        color = [1 1 0];
    end
       
    fprintf('%s: VEI: %d Color: [%1.2f %1.2f %1.2f] \n',datestr(start(n)), vei(n), color(1), color(2), color(3)) % display line
    rectangle('Position',[start(n) 0 stop(n)-start(n) 1], 'FaceColor', color) % plot rectangle for each eruption
    datetick('x','yyyy','keeplimits')

end

hold on
whitebg([0.5 0.8 0.9])
plot([yearsdn; yearsdn],[zeros(size(yearsdn)); ones(size(yearsdn))],'w:','LineWidth',10)


f.Children.Position = [0 0 1 1];
f.Children.TickLength = [0 0];
f.Units = 'centimeters';
f.Position(3) = 20*5;
f.Position(4) = 1.75*5;
f.InvertHardcopy = 'off';
f.PaperPositionMode = 'auto';
print('~/Desktop/BoxTimeLine','-dpng','-r0')

