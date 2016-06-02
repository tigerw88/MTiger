%% createTurrialbaRSAM
% Load data from Winston and produce helicorders or RSAM
%
% This code is set up to go through Winston data and make day long
% helicorders and RSAM plots for whatever time interval you specify. RSAM 
% is returned as a waveform object from the GISMO suite, and it is written 
% to a CSV file in a folder you specify. Helicorders are printed and saved 
% to a folder that you specify. You can define a filter and run multiple 
% stations at once. You can choose to only do RSAM, only do Helicorders, do
% both, or do none (though the later would be pointless).

%% NOTES TO SELF:

% 1. I am in the process of turning this into a general routine processing
% script.
% 2. change the way RSAM is stored - it now stores it as a downsamples
% waveform object.

%% User Input

    % User defined tasks to complete
createHelis = 0; % #ok<NASGU> #ok<MSNU> boolean create Helicorder
saveHelis = 1; % save helicorder (note, if saveHelis is '1', createHelis will automatically become '1')
mpl = 30; % minutes per line on helicorder
rsamInterval = 10; % { 0 == do not create RSAM | n == n minute RSAM interval }
% trace_color = colors.earthworm;
filterobj = filterobject('B', [0.5 40], 4);

    % User parameters - instrument code & output directories
ds = datasource('winston', '130.118.152.130', 16022);
% tag = ChannelTag({'OV.VTCG.--.HHZ', 'OV.VICA.--.HHZ', 'OV.VIMO.--.HHZ', 'OV.VTRE.--.HHZ'});
tag = ChannelTag({'OV.VTCG.--.HHZ'});
base_dir = '/Users/jaywellik/Desktop/CostaRica/TurrialbaResponse/test/';

tstart = datenum('2016/02/01');
tstop = datenum('2016/02/05');


%% run

for s = 1:numel(tag)
    
    
    %% auto-preparation
    
    if saveHelis, createHelis = 1; end % #ok<UNRCH> boolean - savings requires creating
    
    output_dir = [base_dir tag(s).string '/'];
    mkdir(base_dir);
    mkdir(output_dir);
    
%     load('colors.mat')
    rsam = waveform(); rsam = set(rsam, 'ChannelTag', tag(s)); % initialize rsam object
    
    %% compute RSAM
    
    t = tstart;
    while(t <= tstop)
        
        w = waveform(ds, tag(s), t, t+1);
        
        w = demean(w);
        w = fillgaps(w, 0, NaN);
        
        if ~isempty(w)
            
            w = filtfilt(filterobj, w);

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
                
                clr = {[0 0 0], [1 0 0], [0 0 1], [0.25 0.75 0]}; % hard-coded for Earthworm style plots
                heli = helicorder(w); % create the helicorder object
                heli.mpl = mpl; % minutes per line
                heli.trace_color = clr; % specify color type
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
    writeRSAM2file( RSAM(s), output_dir );
    
end
