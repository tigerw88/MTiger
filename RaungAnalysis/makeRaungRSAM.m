%% makeRaungRSAM - FromWinston

%% NOTES TO SELF:

% 1. I am in the process of turning this into a general routine processing
% script.
% 2. change the way RSAM is stored - it now stores it as a downsamples
% waveform object.

%% User Input

    % User defined tasks to complete
createHelis = 0; % boolean
saveHelis = 0; % boolean
rsamInterval = 10; % { 0 == do not create RSAM | n == n minute RSAM interval }

    % User parameters - instrument code & output directories
tag = ChannelTag('RC.KBUR.--.EHZ');
mkdir ~/Desktop/RaungHelicorders/;
mkdir(['~/Desktop/RaungHelicorders/' tag.string '/'])

    % User parameters - data source and times
ds = datasource('winston','localhost',16022);
% ds = datasource('winston','192.168.0.130',16027);
scnl = scnlobject(tag.station,tag.channel,tag.network,tag.location);
tstart = datenum('2015/05/01 00:00:00');
tstop = datenum('2015/08/31 00:00:00');

%% auto-preparation

load('colors.mat')
rsam_run = rsam; % initialize RSAM variable

%% run

t = tstart;
while(t <= tstop)

    w = waveform(ds, scnl, t, t+1);

    if ~isempty(w)
        
        % Create RSAM
        if ( rsamInterval > 0 )
            
            tmp_rsam = resample(w, 'rms', get(w,'freq')*60*rsamInterval); % "get(w,'freq')*60*rsamInterval" grabs rsamInterval minutes worth of data
%             rsam_run.dnum = [rsam_run.dnum; tmp_rsam.dnum]; % datenums are stored as a column vector
%             rsam_run.data = [rsam_run.data tmp_rsam.data]; % values are stored as a row vector.
        
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