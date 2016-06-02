%% createTurrialbaRSAM

%% NOTES TO SELF:

% 1. I am in the process of turning this into a general routine processing
% script.
% 2. change the way RSAM is stored - it now stores it as a downsamples
% waveform object.

%% User Input

    % User defined tasks to complete
createHelis = 0; % #ok<NASGU> #ok<MSNU> boolean
saveHelis = 0;
rsamInterval = 10; % { 0 == do not create RSAM | n == n minute RSAM interval }
mpl = 30;
% trace_color = colors.earthworm;

    % User parameters - instrument code & output directories
ds = datasource('winston', '130.118.152.130', 16022);
% tag = ChannelTag({'OV.VTCG.--.HHZ', 'OV.VICA.--.HHZ', 'OV.VIMO.--.HHZ', 'OV.VTRE.--.HHZ'});
tag = ChannelTag({'OV.VTCG.--.HHZ'});
base_dir = '/Users/jaywellik/Desktop/CostaRica/TurrialbaResponse/test/';

tstart = datenum('2016/01/01');
tstop = datenum('2016/05/31');


%% run

for s = 1:numel(tag)
    
    
    %% auto-preparation
    
    if saveHelis, createHelis = 1; end % #ok<UNRCH> boolean - savings requires creating
    
    output_dir = [base_dir tag(s).string '/'];
    mkdir(base_dir);
    mkdir(output_dir);
    
%     load('colors.mat')
    rsam = waveform(); rsam = set(rsam, 'ChannelTag', tag(s)); % initialize rsam object
    % w_all = waveform(); w_all = set(w_all, 'ChannelTag', tag); % initialize waveform object for all data
    
    %% compute RSAM
    
    t = tstart;
    while(t <= tstop)
        
        w = waveform(ds, tag(s), t, t+1);
        
        w = demean(w);
        w = fillgaps(w, 0, NaN);
        
        if ~isempty(w)
            
            % Create RSAM
            if ( rsamInterval > 0 )
                
                rsamIntervalSec = rsamInterval*60;
                tmp_rsam = waveform2rsam(w, 'rms', rsamIntervalSec);
                tmp_wrsam = waveform();
                tmp_wrsam = set(tmp_wrsam, 'start', tmp_rsam.dnum(1));
                tmp_wrsam = set(tmp_wrsam, 'freq', 1/rsamIntervalSec);
                tmp_wrsam = set(tmp_wrsam, 'ChannelTag', tag(s));
                tmp_wrsam = set(tmp_wrsam, 'data', tmp_rsam.data);
                
                rsam = combine([rsam tmp_wrsam]);
                
            end
            
            % Create and save Helicorder
            if createHelis
                
                heli = helicorder(w); % create the helicorder object
                heli.mpl = mpl; % minutes per line
                heli.trace_color = trace_color; % specify color type
                build2(heli) % display the helicorder
                
                if saveHelis
                    saveas(gcf,[output_dir datestr(t,'yyyy-mm-dd') '.jpg']) % save jpg
                    savefig(gcf,[output_dir datestr(t,'yyyy-mm-dd') '.fig']) % save Matlab figure
                end
                
            end
            
        end
        
        % increment time
        t = t+1;
        close all
        clear w tmp_rsam
        
    end
    
    RSAM(s) = rsam;
%     writeRSAM2file( RSAM(s), output_dir );
    
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
