function [stair_x, stair_y] = makeStair1(x, y)
% MAKESTAIR Poor man's version of making a line plot look like a stair
% plot. This is super lame because Matlab does this automatically, but the
% automatic version doesn't freakin' work with the 'datetime' variable
% type, so I have to get around it on my own!
% NOTES: Can only handle 1 vector of x and y each
% NOTES: May not return vector in same dimension

%%

% stub data for testing
% x = [1 2 3 4]
% y = [1 3 1 4]


%% main

l = length(x); % length of original vectors
dx = x(2) - x(1); % gap between 2 two values

stair_x(1:l*2) = zeros;
stair_y(1:l*2) = zeros;

stair_x(1:2:l*2) = x; % takes care of all odd indices
stair_x(2:2:l*2) = x+dx; % takes care of all even indices
stair_y(1:2:l*2) = y; % takes care of all odd indices
stair_y(2:2:l*2) = y; % takes care of all even indices

%% Plotting routine for testing

% a(1) = subplot(211)
% plot(x,y)
% % xlim([stair_x(1) stair_x(end)])
% zoom xon
% 
% a(2) = subplot(212)
% plot(stair_x, stair_y)
% % xlim([stair_x(1) stair_x(end)])
% zoom xon
% linkaxes(a,'x')

% end