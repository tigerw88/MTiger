%% Projecting to UTM

%{
Of course, you can set up a UTM projection to calculate coordinates without a map display. There are commands to help you pick the zone designation and an appropriate ellipsoid.

utmzone(40.5,-73.5)

ans =

18T

[ellipsoid,estr] = utmgeoid('18T')

ellipsoid =

    6378206.40          0.08


estr =

clarke66
%}

%% Set up the UTM projection and calculate the grid coordinates without a map display.

%{
close all
mstruct = defaultm('utm');
mstruct.zone = '18T';
mstruct.geoid = almanac('earth','geoid','m','clarke66');
mstruct = defaultm(utm(mstruct));
[x,y] = mfwdtran(mstruct,40.5,-73.5)

x =

     627106.47


y =

    4484124.43

%}

%% Project physical data

    % define coordinates to project
vlat = 59.3626, vlong = -153.4350, % volcano coordinates
elat = extractfield(catalog_s, 'Latitude'), elon = extractfield(catalog_s, 'Longitude') % event coordinates
latann, longann

    % define utm zone and geoid
utm_zone = utmzone(vlat,vlong) 
[ellipsoid, estr] = utmgeoid(utm_zone)

    % define matlab structure
mstruct = defaultm('utm');
mstruct.zone = utm_zone;
mstruct.geoid = almanac('earth','geoid','m',estr)
mstruct = defaultm(utm(mstruct))

    % projection system
[vx, vy] = mfwdtran(mstruct,vlat,vlong) % volcano x&y
[ex, ey] = mfwdtran(mstruct,extractfield(catalog_s, 'Latitude'), extractfield(catalog_s, 'Longitude')) % event x&y
[annx, anny] = mfwdtran(mstruct,latann,longann) % annulus x&y

    % plot results thus far
figure(1), scatter(ex, ey, 'ok'), hold on, scatter(vx, vy, '^r'), plot(annx, anny, 'r'), axis square


%%  Prepare cross section (Approach 1)
% All of this works, but the next section is a little cleaner.
% 
% xs_length = 50*1000 % half length of x-section length (m)
% theta = 30*pi/180 % rotation angle (radians)
% 
%     % define the un-rotated x-section lines
% A = [vx+xs_length; vy] % cross section A end point (positive)
% B = [vx; vy+xs_length] % cross section B end point (positive)
% 
%     % rotate the x-section lines
%     % subtracting by the volcano coordinates centers the rotation at (0,0); add it back after rotating
% Ar = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[A(1)-vx; A(2)-vy], Ar(1) = Ar(1)+vx, Ar(2) = Ar(2)+vy 
% Br = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[B(1)-vx; B(2)-vy], Br(1) = Br(1)+vx, Br(2) = Br(2)+vy
% 
% 
%     % plot
% figure(2), scatter(ex, ey, 'ok'), hold on, scatter(vx, vy, '^r'), plot(annx, anny, 'r'), axis square
% plot([vx A(1)], [vy A(2)], 'k') % cross section A line
% plot([vx Ar(1)], [vy Ar(2)], 'r') % cross section A' line; add volcano point to
% 
% plot([vx A(1)], [vy A(2)], 'k') % cross section A line
% plot([vx Ar(1)], [vy Ar(2)], 'r') % cross section A' line; add volcano point to
% 
% plot([vx B(1)], [vy B(2)], 'k') % cross section B line
% plot([vx Br(1)], [vy Br(2)], 'r') % cross section B' line
% 
% axis square

%% Prepare the cross-section (Approach 2)

x = 1; y =2; % enumerate x&y cartesian axes with Matlab vector syntax

xs_length = 50*1000 % half-length of x-section length (m)
theta = 45*pi/180 % rotation angle (radians)

    % define cross-section end points
A1 = [vx-xs_length; vy] % coordinates of point A
A2 = [vx+xs_length; vy] % coordinates of point A'

B1 = [vx; vy+xs_length] % coordinates of point B
B2 = [vx; vy-xs_length] % coordinates of point B'

    % rotate cross-sections
A1r = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[A1(1)-vx; A1(2)-vy] + [vx; vy]
A2r = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[A2(1)-vx; A2(2)-vy] + [vx; vy]
B1r = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[B1(1)-vx; B1(2)-vy] + [vx; vy]
B2r = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[B2(1)-vx; B2(2)-vy] + [vx; vy]


    % plot - unrotated
figure(3)
scatter(ex, ey, 'ok'), hold on, scatter(vx, vy, '^r'), plot(annx, anny, 'r'), axis square

    % cross-section end points
plot(A1(x),A1(y),'*b'), plot(A2(x),A2(y),'sb')
plot(B1(x),B1(y),'*b'), plot(B2(x),B2(y),'sb')

plot(A1r(x),A1r(y),'*r'), plot(A2r(x),A2r(y),'sr')
plot(B1r(x),B1r(y),'*r'), plot(B2r(x),B2r(y),'sr')

    % cross-section lines
plot([A1(x) A2(x)],[A1(y) A2(y)],'b')
plot([B1(x) B2(x)],[B1(y) B2(y)],'b')

plot([A1r(x) A2r(x)],[A1r(y) A2r(y)],'r')
plot([B1r(x) B2r(x)],[B1r(y) B2r(y)],'r')


    % rotate the earthquakes - this does NOT use the element by element feature
% ex_ = ex-vx, ey_ = ey-vy
% er = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[ex_; ey_]
% exr = er(1,:)+vx, eyr = er(2,:)+vy

    % rotate earthquakes - use element by element notation
er = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[ex-vx; ey-vy] + [zeros(1,length(ex))+vx; zeros(1,length(ey))+vy]
% er = [cos(theta) -sin(theta); sin(theta) cos(theta)]*[ex-vx; zeros(1,length(ey))] + [zeros(1,length(ex))+vx; zeros(1,length(ey))+vy]
exr = er(1,:), eyr = er(2,:)




plot(exr,eyr, 'or')
