%% makeRaungHelicorders - FromWinston

load('colors.mat')

    % User parameters - instrument code & output directories
nslc = 'RC.KBUR.--.EHZ';
mkdir ~/Desktop/RaungHelicorders/;
mkdir(['~/Desktop/RaungHelicorders/' nslc '/'])

    % User parameters
ds = datasource('winston','localhost',16022);
% ds = datasource('winston','192.168.0.130',16027);
scnl = scnlobject('KBUR','EHZ','RC','--');
tstart = datenum('2015/05/25 00:00:00');
tstop = datenum('2015/05/26 00:00:00');

t = tstart;
while(t <= tstop)

    w = waveform(ds, scnl, t, t+1);
    nslc = [get(scnl,'network') '.' get(scnl,'station') '.' get(scnl,'location') '.' get(scnl,'channel')];
    
    heli = helicorder(w); % create the helicorder object
    heli.mpl = 30; 
    heli.trace_color = colors.earthworm;
    build(heli) % display the helicorder
%     saveas(gcf,['~/Desktop/RaungHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.jpg']) % save jpg
%     savefig(gcf,['~/Desktop/RaungHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.fig']) % save Matlab figure
    
    t = t+1;
%     close all

end

