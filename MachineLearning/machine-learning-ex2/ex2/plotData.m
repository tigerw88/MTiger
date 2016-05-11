function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.
%
% INPUT
%   X -> [m-by-n] test scores, where m is the number of individuals, and n
%   is the number of scores per individual
%   y -> [m-by-1 logical] admitted (1) or not admitted (0)

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

pos = find(y==1); % students admitted
neg = find(y==0); % students not admitted

padmitted = plot(X(pos,1), X(pos,2), ...
    'k+', 'MarkerSize', 7); % plots scores for admitted students
pnotadmitted = plot(X(neg,1), X(neg,2), 'ko', ...
    'MarkerFaceColor', 'y', 'MarkerSize', 7); % plots scores for students not admitted







% =========================================================================



hold off;

end
