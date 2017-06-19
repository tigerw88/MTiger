%% May2015vts

clear ds tags dates w E W, close all

ds = datasource('winston','localhost',16022);
tags = ChannelTag({'RC.KBUR.--.EHZ', ...
    'RC.MLLR.--.EHZ', ...
    'IC.MLTN.--.EHZ'});
clr = {'k', 'b', 'g', 'r'};
% tags = ChannelTag({'RC.MLLR.--.EHZ', ...
%     'RC.MLLR.--.EHN', ...
%     'RC.MLLR.--.EHE'});



% tags = ChannelTag({'RC.RAUN.--.EHZ'});

% dates = [datenum('2015 05 25 03:48:47'), ...
%     datenum('2015 05 25 12:31:00'), ...
%     datenum('2015 05 25 13:01:21'), ...
%     datenum('2015 05 25 13:03:08'), ...
%     datenum('2015 05 25 13:29:10'), ...
%     datenum('2015 05 25 13:30:09'), ...
%     datenum('2015 05 25 13:59:36')];

% dates = [datenum('2014 11 11 11:20:02'), ...
%     datenum('2014 11 11 11:27:22'), ...
%     datenum('2014 11 11 13:56:01'), ...
dates =  [  datenum('2015 05 25 03:48:49'), ...
    datenum('2015 05 25 13:29:15'), ...
    datenum('2015 05 25 13:30:19'), ...
    datenum('2015 05 25 13:59:38')];


% for n = 1:numel(dates);
%     
%     t1 = datenum(dates(n)) - 10/60/60/24; %; goes x seconds before event time
%     w = combine(waveform(ds, tags, t1, t1+0.75/60/24)); % gets 2 minutes of waveform data
%     E(n).w = w;
%         
% end

    % to plot and save one station at a time
% for n = 1:numel(E); W(n) = E(n).w; end
% mp = multiplot(W); saveas(mp,['~/Desktop/multiplot-' tags.string '.png'])

    % to plot and save one event at a time
% mp = multiplot(E(1).w, 'Color', 'b', 'LineWidth', 0.8)


    for D = 1:numel(dates)
        for T = 1:numel(tags)
            
            t1 = datenum(dates(D)) - 10/60/60/24; %; goes x seconds before event time
            w = combine(waveform(ds, tags(T), t1, t1+0.75/60/24)); % gets 2 minutes of waveform data
            w = detrend(w);
            w = set(w, 'data', get(w,'data')/max(abs(get(w, 'data')))-0.75*(T-1));
            
            subplot(numel(dates), 1, D)
            plot(w, clr{T}, 'xunit', 'Date'), hold on
            clear w
        
        end
    end
    
t = dates(4);   
subplot(3,1,1), plot(waveform(ds, tags(1), t-5/86400, t+25/86400), 'Color', 'k', 'xunit', 'Date')
subplot(3,1,2), plot(waveform(ds, tags(2), t-5/86400, t+25/86400), 'Color', 'k', 'xunit', 'Date')
subplot(3,1,3), plot(waveform(ds, tags(3), t-5/86400, t+25/86400), 'Color', 'k', 'xunit', 'Date')



