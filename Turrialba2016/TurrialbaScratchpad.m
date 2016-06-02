%% Turrialba Scratchpad

%% Plot helicorder and zoom into things

cr1 = scnlobject({'VTRT', 'VTCG', 'VTCE'}, 'HHZ', 'OV', '--');
tstart = datenum('2015/12/01');
w = irisFetch2wo('waveform', cr1, tstart, tstart+1);
r = waveform2rsam(w, 'rms', 10*60); figure; plot(r.dnum, r.data)

w = combine(w);
heli = helicorder(w, 'mpl', 30, 'scale', 20);
h = build2(heli);

heliPointer(heli);


%% Look at individual events

% cr1 = scnlobject('VTCG', {'HHZ', 'HHN', 'HHE'}, 'OV', '--');
% w = irisFetch2wo('waveform', cr1, datenum('2016-05-24 07:45'), datenum('2016-05-24 07:47'));

Z = 1; N = 2; E = 3;
channel = {'HHZ', 'HHN', 'HHE'};

for comp = [Z N E]
    
    cr1(comp) = scnlobject('VTCG', channel(comp), 'OV', '--');
    w(comp) = irisFetch2wo('waveform', cr1(comp), datenum('2016-05-24 20:17'), datenum('2016-05-24 20:20'));
    
    subplot(3,1,comp)
    plot(w(comp))
    
end

particleMotion(w);






