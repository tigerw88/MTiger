%% makeRaungHelicorders - FromWinston

load('colors.mat')

    % User parameters - instrument code & output directories
nslc = 'RC.KBUR.--.EHZ';
mkdir ~/Desktop/TestHelicorders/;
mkdir(['~/Desktop/TestHelicorders/' nslc '/'])

filterObj = filterobject('L',2,4); % comment this line to not use filter

    % User parameters
ds = datasource('winston','localhost',16022);
% ds = datasource('winston','192.168.0.130',16027);
tstart = datenum('2015/05/25 00:00:00');
tstop = datenum('2015/05/26 00:00:00');

t = tstart;

% grabs one day of data at a time, filters if applicable, plots helicorder, and saves helicorder image
while(t <= tstop)

    w = waveform(ds, ChannelTag(nslc), t, t+1); % get one day of data
    
    if which('filterObj')
        
        display('Filtering data...')
        wunfiltered = w;
        w = demean(wunfiltered); % demean data so that it is centered at 0
        w = fillgaps(w, 0, NaN); % replace NaN values with 0
        w = filtfilt(filterObj, w);
        filterStr = sprintf('Filtered: %s, %1.1f Hz, %d poles', get(filterObj, 'Type'), get(filterObj, 'Cutoff'), get(filterObj, 'Poles'));
        
    end
    
    heli = helicorder(w); % create the helicorder object
    heli.mpl = 30;
    heli.trace_color = colors.earthworm;
    build(heli) % display the helicorder
    if which('filterObj'), ax = gca; ax.Title.String = {ax.Title.String; filterStr}; end
    saveas(gcf,['~/Desktop/TestHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.jpg']) % save jpg
    savefig(gcf,['~/Desktop/TestHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.fig']) % save Matlab figure
    
    t = t+1; % increment time by 1 day
    close all

end

