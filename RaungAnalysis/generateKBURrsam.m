% generate monthly RSAM
% * monthly RSAM
% * removes calibration pulses 
%

rsamrate.sr = 1;
rsamrate.freq = NaN;
rsamrate.str = [num2str(rsamrate.sr) 'min'];

ds = datasource('winston', 'localhost', 16022);
tag = ChannelTag('D.REF.--.EHZ');
t1 = datetime(2009,06,01);
t2 = datetime(2015,01,31);
basedir = '/Users/jaywellik/Dropbox/JAY-DATA/RSAM/';
basedirW = '/Users/jaywellik/Dropbox/JAY-DATA/W/';

%%

R = []; W = [];

for m = t1:calmonths(1):t2

    disp(m)
    
    for t = m:m+calmonths(1)-1

        w = waveform(ds, tag, datenum(t), datenum(t+1));
        if ~isempty(w)
            try
                w2 = mcvco2nan(w);
%                 r = basicW2RSAM(w2, 'rms', rsamrate.sr);
%                 R = combine([R r]);
                W = combine([W w2]);
                fpath = fullfile(basedir, tag.string, rsamrate.str);
                fpathw = fullfile(basedir, tag.string);
                if ~exist(fpath, 'dir'), mkdir(fpath); end
%                 save(fullfile(fpath, [datestr(m, 'yyyymm') '.mat']), 'R');
                save(fullfile(fpathw, [datestr(m, 'yyyymm') '.mat']), 'W');
            catch
            end
        end
        
    end
    R = [];
    
end

