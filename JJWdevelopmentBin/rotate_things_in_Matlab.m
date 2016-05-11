%% Wingplot

%%

phiA = 30/180*pi; % rotation angle; tangential cross section (parallel to trench
phiB = phiA - 90; % radial cross section

lat = extractfield(catalog_s, 'Latitude');
long = extractfield(catalog_s, 'Longitude');
z = extractfield(catalog_s, 'Depth');

% [x, y] = mfwdtran(lat, long);
% x = long;
% y = lat;
x = 1:100;
y = zeros(1,100);

xy1_coords = [cos(phiA) -sin(phiA); sin(phiA) cos(phiA)]*[x; y];
x1 = xy1_coords(1,:);
y1 = xy1_coords(2,:);

plot(x,y,'ok')
hold on; plot(x1,y1,'or');


