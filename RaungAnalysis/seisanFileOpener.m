function seisanFileOpener(datadir, channel_tag, t1, t2, file_length)
% SEISANFILEOPENER Given a station, t1, and t2, finds all appropriate
% files, opens the waveforms, and merges the data into a single waveform
% object
%
% INPUT:
% parent_dir - parent directory of Seisan files
% channel_tag - a ChannelTag object
% t1 - start time (datenum)
% t2 - stop time (datenum)
% file_length - the length of each Seisan file (minutes)
%
% OUTPUT:
% w - waveform object
%

t1dv = datevec(t1); t1dv(5) = floor(t1dv(5)/10)*10; t1 = datenum(t1dv);
times = [t1:file_length/60/24:t2]; % creates vector of dates that correspond to the start times of the Seisan Files that are needed

for n = numel(times)
    
    dvec = times(n)
    
    % e.g., %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
    partfname = fprintf('%s/%d/%d_02d/%d%02d%02d/Set00/%d-%02d0%02d-%02d%02d-%02dS'
%     load_seisan2(partfname)
    
   % load_seisan2(...) 
    
end

end