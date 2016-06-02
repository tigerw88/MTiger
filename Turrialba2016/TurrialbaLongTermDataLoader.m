%% Turrialba Long Term Data Loader


cr = scnlobject({'VTCG' 'VTCE'}, 'HHZ', 'OV', '--');
dates = datenum('2016/05/01'):1:datenum('2016/05/10');


for ssss = 1:numel(cr)
    
    for dd = 1:numel(dates);
        
        tmpw(dd) = irisFetch2wo('waveform', cr(ssss), dates(dd), dates(dd)+1);
        %         r = waveform2rsam(w, 'rms', 10*60); figure; plot(r.dnum, r.data)
        
    end
    
    w(ssss) = combine(tmpw);
    
end
