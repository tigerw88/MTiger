clear w data

    % user-suplied information
basedir = '/Volumes/RaungBackup/RaungSAC/';
tag_str = {'RC.KBUR.--.EHZ'; 'RC.MLLR.--.EHZ'; 'RC.RAUN.--.EHZ'; 'RC.POSR.--.EHZ'};
% t1 = datenum('2014/11/11 13:55:50');
% t2 = datenum('2014/11/11 13:58:00');
t1 = datenum('2015/02/07 04:14:00');
t2 = datenum('2015/02/07 04:20:00');

figure(1)
for n = 1:numel(tag_str)
    
        % parse out necessary parts
    tag = ChannelTag(tag_str{n});
    scnl_str = scnlString(tag);
    t1dv = datevec(t1);
    year = t1dv(1); month = t1dv(2); date = t1dv(3);
    hour = t1dv(4); minute = t1dv(5); second = t1dv(6);
    minute2 = floor(minute/20)*20; % start of appropriate SAC file in minutes
    
    % create file name
    % filename_ex = ...
    %     '/Volumes/RaungBackup/RaungSAC/2014/201411/20141112_134000_MAN/KBUR.EHZ.RC.--';
    fpath_timefolder = sprintf('%04d/%04d%02d/%04d%02d%02d_%02d%02d00_MAN',year,year,month,year,month,date,hour,minute2);
    filename = fullfile(basedir,fpath_timefolder,scnl_str);
    
        % grab data
    ds = datasource('sac',filename);
    w(n) = waveform(ds, tag, t1, t2);
    w(n) = extract(w(n),'TIME',t1,t2);
    w(n) = demean(w(n));
    data(:,n) = get(w(n),'data');
    
    ax(n) = subplot(numel(tag_str),1,n); plot(w(n),'k','LineWidth',2); hold on
    
end
zoom xon;
linkaxes(ax,'x')


%%

figure(2)
[r, lag] = xcorr(data(:,1), data(:,2));
plot(r), zoom xon
