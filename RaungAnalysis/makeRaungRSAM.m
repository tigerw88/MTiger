%% makeRaungRSAM - FromWinston

%% NOTES TO SELF:

% 1. I am in the process of turning this into a general routine processing
% script.
% 2. change the way RSAM is stored - it now stores it as a downsamples
% waveform object.

%% User Input

    % User defined tasks to complete
createHelis = 0; % #ok<NASGU> #ok<MSNU> boolean
saveHelis = 0; if saveHelis, createHelis = 1; end % #ok<UNRCH> boolean - savings requires creating
rsamInterval = 10; % { 0 == do not create RSAM | n == n minute RSAM interval }

    % User parameters - instrument code & output directories
tag = ChannelTag('IC.MLTN.--.EHZ');
mkdir ~/Desktop/RaungHelicorders/;
mkdir(['~/Desktop/RaungHelicorders/' tag.string '/'])

    % User parameters - data source and times
ds = datasource('winston','localhost',16022);
% ds = datasource('winston','192.168.0.130',16027);
scnl = scnlobject(tag.station,tag.channel,tag.network,tag.location);
tstart = datenum('2014/11/01 00:00:00');
tstop = datenum('2015/08/31 00:00:00');

%% auto-preparation

load('colors.mat')
rsam = waveform(); rsam = set(rsam, 'ChannelTag', tag); % initialize rsam object
% w_all = waveform(); w_all = set(w_all, 'ChannelTag', tag); % initialize waveform object for all data

%% run

t = tstart;
while(t <= tstop)

    w = waveform(ds, scnl, t, t+1);

    if ~isempty(w)
        
        % Create RSAM
        if ( rsamInterval > 0 )
            
            tmp_rsam = waveform2rsam(w, 'rms', rsamInterval);
            tmp_wrsam = waveform();
            tmp_wrsam = set(tmp_wrsam, 'start', tmp_rsam.dnum(1));
            tmp_wrsam = set(tmp_wrsam, 'freq', 1/(rsamInterval*60));
            tmp_wrsam = set(tmp_wrsam, 'ChannelTag', tag);
            tmp_wrsam = set(tmp_wrsam, 'data', tmp_rsam.data);

            rsam = combine([rsam tmp_wrsam]);
            
            %             w_all = combine([w_all w]);
% %             tmp_rsam = resample(abs(w), 'mean', get(w,'freq')*60*rsamInterval); % "get(w,'freq')*60*rsamInterval" grabs rsamInterval minutes worth of data
% %             rsam = combine([rsam tmp_rsam]);
        
        end
        
        % Create and save Helicorder
        if createHelis
            
            heli = helicorder(w); % create the helicorder object
            heli.mpl = 30;
            heli.trace_color = colors.earthworm;
            build(heli) % display the helicorder
            
            if saveHelis
                saveas(gcf,['~/Desktop/RaungHelicorders/' tag.string '/' datestr(t,'yyyy-mm-dd') '.jpg']) % save jpg
                savefig(gcf,['~/Desktop/RaungHelicorders/' tag.string '/' datestr(t,'yyyy-mm-dd') '.fig']) % save Matlab figure
            end
        
        end
        
    end

    % increment time
    t = t+1;
    close all
    clear w tmp_rsam

end



%% NOTES TO SELF:

%{
I cleaned up some of the RSAM results by removing everything that was above
10000 counts. Somehow, the MLTN station has values that are Ne18 for some
reason. Those values needed to be removed, obviously.

Also, be aware of nan values. By using the waveform object to store the
data, it appears to take care of the nan values. Otherwise, dividing by nan
when making the RSAM ratios would cause the whole vector of data to be nan.
%}
