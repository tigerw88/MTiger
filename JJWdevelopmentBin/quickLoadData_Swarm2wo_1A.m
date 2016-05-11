function w = quickLoadData_Swarm2wo_1A(filenames)
%  quickLoadData.m
% ------------------
% This function quickly loads data exported from Swarm into the GISMO suite for Matlab. It
% loads the data into Matlab as a matrix of waveform objects for each channel.
%
% USAGE:
% 
% >> file1 = '/...../BHZ.txt';
% >> file2 = '/...../BHN.txt';
% >> file3 = '/...../BHE.txt';
% >> all_files = [file1; file2; file3];
% >> w = quickLoadData(all_files); % w is a matrix of waveform objects

% Determine whether or not GISMO has been loaded
% ! not functioning - this script will crash if GISMO is not loaded

	% Determine the number of files
n_files = size(filenames,1); % returns the number of rows in 'filenames'

	% set the time vector
	% note, time is returned as a column vector.
t_tmp = dlmread(filenames(1,:)); % read in the whole first file
t = t_tmp(:,1); % only store the first column

w = waveform(); % initializes a blank waveform object

for n = 1:n_files

		% put each string of data into a column vector
	tmp_trace(:,n) = dlmread(filenames(n,:),'',0,1); % reads only the second column of data (the waveform trace); default treatment of delimitter
	w(n) = set(w(n),'data',tmp_trace); % puts trace into the waveform object
	clear tmp_trace;
	
		% parse SCNL info from the filename
        strtok(filenames(1,:),'.')
	C = strsplit(strtok(filenames(1,:),'.'),'_')
	
		% put station, channel, and network into waveform object
	w(n) = set(w(n),'station',C{1});
	w(n) = set(w(n),'channel',C{2});
	w(n) = set(w(n),'network',C{3});
	clear C;
	
		% set the start time for the waveform object
	w(n) = set(w(n),'start',t(1));	

end

end % :-)