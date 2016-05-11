%% An example of a histogram with 2 time series (use left & right y axes)

    % plot timeline
plot([redoubt2009.time redoubt2009.time],[0 length(redoubt2009.txt)],'r'), hold on
text(datenum(redoubt2009.time),4+(1:length(redoubt2009.txt))/2,redoubt2009.txt)
ylim([0 length(redoubt2009.txt)/2])
title('Timeline of the 2009 Redoubt Eruption')


    % plot timeline - to go with histogram of events per day
hist((DateTime), date_range), hold on
plot([redoubt2009.time redoubt2009.time],[0 max(events_per_d)*1.05],'r'), hold on
ytextpos = 100+(1:10:length(redoubt2009.txt)*10);
text(datenum(redoubt2009.time),ytextpos,redoubt2009.txt)
ylim([0 max(events_per_d)])
title({'Redoubt 2009';'ANSS Catalog Events within 45km of summit & <= 20km depth'})
ylabel('Events Per Day')
xlabel('Date')