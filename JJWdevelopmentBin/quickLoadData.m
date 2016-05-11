function [w, t] = quickLoadData(filenames)
%  quickLoadData.m
% ------------------
% This function quickly loads data exported from Swarm in the Matlab format. It
% loads the data into Matlab as an n x m matrix where m (the columns) is the number of
% stations and n (the rows) is the length of the data in samples. A time vector, t, is also returned
% as a column vector.
%
% USAGE:
% 
% >> file1 = '/...../BHZ.txt';
% >> file2 = '/...../BHN.txt';
% >> file3 = '/...../BHE.txt';
% >> all_files = [file1; file2; file3];
% >> [w, t] = quickLoadData(all_files); % w is column vectors of data; t is a column vector of time


% Determine the number of files
n_files = size(filenames,1 ); % returns the number of rows in 'filenames'

% set the time vector
% note, time is returned as a column vector.
t_tmp = dlmread(filenames(1,:)); % read in the whole first file
t = t_tmp(:,1); % only store the first column


for n = 1:n_files

	% put each string of data into a column vector
	w(:,n) = dlmread(filenames(n,:),'',0,1); % reads only the second column of data; default treatment of delimitter

end

end % :-)