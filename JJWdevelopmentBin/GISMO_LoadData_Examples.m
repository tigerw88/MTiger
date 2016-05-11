%% GISMO_LoadData_Examples
% A lot of this is covered in the documentation for the GISMO suite, but I
% still find it easier to see past examples of things that worked.

%% SEISAN file
% This example does not work. I am not sure of the problem. There is no
% reason, yet, to think that the file is bad.

ds = datasource('seisan','/Volumes/RaungBackup/RaungSeisan/2012/20121030/Set00/2012-10-29-2350-00S.MAN___006');
scnl = scnlobject('MLLR','EHZ','RC','--');
w = waveform(ds, scnl, '2012/10/29 23:50:00', '2012/10/29 23:59:59');


%% SAC file

ds = datasource('sac','/Volumes/RaungBackup/RaungSAC/2015/201507/20150701_000000_MAN/KBUR.EHZ.RC.--');
scnl = scnlobject('MLLR','EHZ','RC','--');
w = waveform(ds, scnl, '2012/10/29 23:50:00', '2012/10/29 23:59:59');

%% Winston

mkdir ~/Desktop/RaungHelicorders/;
nslc = 'RC.KBUR.EHZ.--';
mkdir(['~/Desktop/RaungHelicorders/' nslc '/'])


ds = datasource('winston','localhost',16022);
scnl = scnlobject('KBUR','EHZ','RC','--');
t = datenum('2015/07/01 00:00:00');

while(t <= datenum('2015/07/31'))

    w = waveform(ds, scnl, t, t+1);
%     nslc = [get(w,'network') '.' get(w,'station') '.' get(w,'channel') '.' get(w,'location')];
    
    heli = helicorder(w);
    heli.mpl = 30;
    heli.trace_color = colors.earthworm;
    build(heli)
    saveas(gcf,['~/Desktop/RaungHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.jpg'])
    savefig(gcf,['~/Desktop/RaungHelicorders/' nslc '/' datestr(t,'yyyy-mm-dd') '.fig'])
    
    t = t+1;
    close all

end

