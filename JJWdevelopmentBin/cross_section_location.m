% x  = [1 2 3 4 5];
% y = [1 3 5 7 9];
% 
% theta = -45*pi/180
% 
% AA  = [10,10];
% 
% plot(x,y,'ok'), hold on
% plot(AA(1), AA(2), '*b')
% xlim([-15 15])
% ylim([-15 15])
% 
% 
% r = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[x; y]
% 
% plot(r(1,:),r(2,:),'ob')
% 
% x2 = x*cos(theta-90)-y*sin(theta-90)
% y2 = x*cos(theta-90)-y*sin(theta-90)
% 
% plot(x2, y2, 'or')

clc
close all

%%

% SEE Notebook #2, p. AB (VDAP2-AB) for discussion

    % data - combination of [x y] points
% data = [3 5; 7 1; 2 -3; 6.5 -7; ; -6 2; -4 3];
l = 8; % radius of line to be drawn - only used for graphics
data1 = [3 5; 7 1]; % Quadrant 1
data2 = [-6 2; -4 3]; % Quadrant 2
data3 = [-1 -4; -5 -5]; % Quadrant 3
data4 = [2 -3; 6.5 -7]; % Quadrant 4
data = [data1; data2; data3; data4];

    % plot the data
plot(data(:,1),data(:,2),'ok'); hold on;
plot([-l l],[0 0],'k'); % major x axes
plot([0 0],[-l l],'k'); % major y axes
axis square

    % add in a line at angle theta and a line v
theta = 30 * pi/180;
v = [0 0; l*cos(theta) l*sin(theta)];

    % plot the angled line
plot([0 v(2,1)],[0 v(2,2)],'b', 'LineWidth', 2)  
plot([-v(2,1) 0],[-v(2,2) 0],'b--', 'LineWidth', 2)  


    % project the points
a = sqrt(data(:,1).^2 + data(:,2).^2); % distance from origin to point
angle = atan2(data(:,2),data(:,1)); % angle from origin to point
phi = angle - theta; % angle between xsection vector and vector to point
b = a .* cos(phi); % length along cross section from origin

    % plot projected points
plot(b*cos(theta), b*sin(theta), '^b')

    % print summary of data and the projection (this could probably be vectorized)
    for n = 1:length(data(:,1))
        sprintf('(%1.1f, %1.1f) \t Angle to point =  %2.2f \t Phi =  %2.2f \t b = %2.2f \t (%2.2f, %2.2f) \n',...
            data(n,1), data(n,2), angle(n) / pi * 180, phi(n) / pi * 180, b(n), b(n)*cos(theta), b(n)*sin(theta))
    end

