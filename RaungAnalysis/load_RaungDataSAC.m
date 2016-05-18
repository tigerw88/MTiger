function EVENT = load_RaungDataSAC(directoryformat, tags, t1, t2)
% LOAD_RAUNGDATASAC Grabs SAC data from a consistent file structure
% Based on t1 and t2 and the file length for each SAC file, this function
% open all necessary files from a directory, merges the waveform data, and
% clips those data to the times t1 and t2. This operation is done for each
% station specified by tags.
%
% HARD-CODED in the body of this function
% + filename (filestructure) - Currently handles only one file structure,
% which is hard-coded into the body of the function.
% + file_length - minutes of seismic data per SAC file
% + Other notes: This function only works for SAC files. The directory
% structure must be consistent.
%
% INPUT
% + directoryformat - a cell array of strings that describes the directory
% and file name structure for the files
%   e.g., a file structure of:
%       /Volumes/2014/03/17-KBUR.sac
%   would be described by the following format:
%       {'/Volumes/%04d/%02d/%02d-%s.sac','year','month','day','station'}
% %s can hold the place for 'station', 'channel', 'network', or
% 'location;
% %d can hold the place for 'year', 'month', 'day', 'jday', 'hour',
% 'minute', or 'second'
% See datasource for more details
% %+ basedir - the directory where the SAC data are stored
% + tags - list of ChannelTag objects that you want to retrieve
% + t1 - array of start times for data
% + t2 - array of stop times for data
%
% OUTPUT
% + EVENT - 1-by-n structure of "events." Each event contains 1-by-m waveform
% objects where m corresponds to the number of ChannelTags provided in the
% input. Data length is clipped to t1 and t2 for each event.
%
% USAGE
% >> E = load_RaungDataSAC({'/Volumes/%04d/%02d/%02d-%s.sac','year','month','day','station'}, ...
%       ChannelTag({'RC.KBUR.--.EHZ', 'RC.MLLR.--.EHZ'}), ...
%       {'2014/11/11 11:05:00', '2015/05/28 13:05:00'}, {'2014/11/11 11:25:00', '2015/05/28 13:45:00'})
%

% stub information
% basedir = '/Volumes/RaungBackup/RaungSAC/'
% tags = ChannelTag({'RC.KBUR.--.EHZ', 'RC.MLLR.--.EHZ'})
% t1 = {'2014/11/11 11:05:00', '2015/05/28 13:05:00'}
% t2 = {'2014/11/11 11:25:00', '2015/05/28 13:45:00'}

%% run

file_length_min = 20; % minutes of seismic data in each sac file - hard-coded




for i = 1:numel(tags) % - executed for each ChannelTag
    
        % parse information from ChannelTag object
    network = tags(i).network; station = tags(i).station;
    location = tags(i).location; channel = tags(i).channel;
    
    for j = 1:numel(t1) % - executed for each event, i.e., for each [t1 t2] pair
        
            % create list of times corresponding to available and relevant sac files
        tdvec = datevec(t1(j)); % converts t1 of j event into type datevec
        tdvec(5) = floor(tdvec(5)/20)*file_length_min; % turns datevec version of t1 into the start time for the file that corresponds to t1
        tdvec(6) = 0; % set all seconds to zero
        times = datenum(tdvec):file_length_min/60/24:datenum(t2(j)); % creates list of all datenum times that correspond to files that need to be opened
        timesdvec = datevec(times); % converts list of datenum to datevec

        
        for n = 1:numel(times)
            
            % - executed for each file on each ChannelTag
            
            % parse year, month, date, hour, minute, second from datevec
            yyyy = timesdvec(n, 1); mm = timesdvec(n, 2); dd = timesdvec(n, 3); HH = timesdvec(n, 4); MM = timesdvec(n, 5); SS = timesdvec(n, 6);
            
            % create filename string based on known file structure
            % filestructure is hard-coded
%             filename = sprintf('%s%04d/%04d%02d/%04d%02d%02d_%02d%02d%02d_MAN/%s.%s.%s.%s', basedir, yyyy, yyyy, mm, yyyy, mm, dd, HH, MM, SS, station, channel, network, location);
%             ds = datasource('sac',filename); % greate GISMO datasource object
            ds = datasource('sac',directoryformat{:})
            w(n) = waveform(ds, tags(i), t1(j), t2(j)); % create waveform from sac file
            
        end
        
        % - executed for each event given the current ChannelTag
        
        w = combine(w(:)); % combine waveform from multiple sac files
        EVENT(j).w(i) = extract(w, 'Time', datenum(t1(j)), datenum(t2(j))); % cut data down to original times given by user
        clear w
        
    end    
    
end

end