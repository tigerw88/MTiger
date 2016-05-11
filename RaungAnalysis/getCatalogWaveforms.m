function E = getCatalogWaveforms( catalog, ds, tags )
% GETCATALOGWAVEFORMS Uses a PVMBG catalog to get waveforms from a Winston

warning('Currently subtracts 7hrs from time to shift WIB to UTC.')

dates = catalog.DateString;

for n = 1:numel(dates);
    
    t1 = datenum(dates{n}) - 7/24 - 10/60/60/24; % adjusts to UTC time; goes x seconds before event time
    w = combine(waveform(ds, tags, t1, t1+2/60/24)); % gets two minutes of waveform data
    E(n).w = w;
        
end

end