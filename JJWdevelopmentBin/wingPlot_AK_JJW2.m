function H = wingPlot_AK2(volcname,catalog,mapdata,vlat,vlon,vdep,sta_lat,sta_lon,sta_elev,plat,plon,latann,longann,r_km,phi,max_depth)
% WINGPLOT Plots data in map view along with cross section profiles.


%% Data Prep

    % Extract all necessary data from the catalog
Lat = extractfield(catalog, 'Latitude');
Lon = extractfield(catalog, 'Longitude');
Depth = extractfield(catalog, 'Depth');
DateTime = datenum(extractfield(catalog, 'DateTime'));
Magnitude = extractfield(catalog, 'Magnitude');
Moment = magnitude2moment(Magnitude); % convert each magnitude to a moment

eq_plot_size = rescaleMoments(Moment,[5 100]); % base event marker size on moment (a way to make a log plot)

t1 = DateTime(1);
t2 = DateTime(2);

max_depth = -(abs(max_depth)); % ensure that the value is negative


%% Figure Prep

    %map axes
latlim = [min([Lat'; latann]) max([Lat'; latann])];
lonlim = [min([Lon'; longann]) max([Lon'; longann])];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .005, .005);

coastlines = mapdata.coastlines;
ZA = mapdata.ZA;
RA = mapdata.RA;

%% Figure

H = figure;

mapview = subplot(3,3,[1 2 4 5]);
ax = usamap(latlim, lonlim);
% mstruct2 = getm(ax)
geoshow(coastlines,'FaceColor', [.75 .75 .75])
title({volcname,[datestr(t1) ' to ' datestr(t2)]})
[~, ~] = contourm(double(ZA),RA,double(200:200:max(max(ZA))),'LineColor','k');
colormap('jet')
freezeColors; % I think this is a non-Matlab function, watch out!

% Plot earthquakes and the volcano
colormap;
scatterm(ax, Lat, Lon, eq_plot_size, DateTime);
caxis([min(DateTime) max(DateTime)])
hcb=colorbar;
datetickJP(hcb,'y',2); % this is a non-Matlab function, watch out!

plotm(vlat, vlon,'dk','MarkerFaceColor','w','MarkerSize',10); % plot the volcano; make a red triangle
plotm(latann, longann, 'k'); % plot the annulus as a black line
plotm(sta_lat, sta_lon,'^k','MarkerFaceColor','k');

% scaleruler('Units','km','RulerStyle','patches');

%% Project Data to Projected (xy) Coordinates

[x,y] = mfwdtran(Lat,Lon); % earthquake events
[vx,vy] = mfwdtran(vlat,vlon); % volcano location
[sta_x, sta_y] = mfwdtran(sta_lat, sta_lon); % station locations
[px, py] = mfwdtran(plat, plon); % location of other summit *p*eaks

z = Depth;


%% Map & XSection


    % phi = the angle (degrees) at which you want to rotate the cross section
if phi == 0; phi = 0.001; end;    
phiB = phi*pi/180; phiA = (phi-90)*pi/180; % radian angle for A and B

r = r_km*1000; % radius (meters)
deepest = -max(Depth); % an odd way to get the depth of the deepest quake (negative value)
highest = max(max(double(ZA)))/1000; % highest elevation in km

    % Define the location of xsection start and stop - points are relative
    % to proj system, not the volcano!
A1.x = vx - r*cos(phiA); A1.y = vy - r*cos(phiA); % xy coords of A
A2.x = vx + r*cos(phiA); A2.y = vy + r*cos(phiA); % xy coords of A'

B1.x = vx - r*cos(phiB); B1.y = vy + r*cos(phiB); % xy coords of B
B2.x = vx + r*cos(phiB); B2.y = vy - r*cos(phiB); % xy coords of B'

    % convert xsection start and stop points back to geo coordinates
[A1.lat, A1.lon] = minvtran(A1.x,A1.y); % lat-long coords of A
[A2.lat, A2.lon] = minvtran(A2.x,A2.y); % lat-long coords of A'

[B1.lat, B1.lon] = minvtran(B1.x,B1.y); % lat-long coords of B
[B2.lat, B2.lon] = minvtran(B2.x,B2.y); % lat-long coords of B'


%     % place A-A' line on mapview
% plotm(A1.lat,A1.lon, 'sr'); % beginning of A xsection
% textm(A1.lat,A1.lon, 'A'); % A xsection label
% 
% plotm([A1.lat A2.lat],[A1.lon A2.lon],'r'); % A-A' xsection
% 
%     % place B-B' on mapview
% plotm(B1.lat,B1.lon, 'sb'); % beginning of B xsection
% textm(B1.lat,B1.lon, 'B'); % B xsection label
% plotm([B1.lat B2.lat],[B1.lon B2.lon]); % B-B' xsection

%%

    % get locations relative to each xs line
x0 = x - vx; y0 = y - vy; % adjust eq coordinates relative to volcano   
AA0 = x0*cos(phiA) - y0*sin(phiA); % transform locs to A-A'
BB0 = x0*cos(phiB) - y0*sin(phiB); % transform locs to B-B'

sta_x0 = sta_x - vx; sta_y0 = sta_y - vy; % adjust station coordinates
sta_AA0 = sta_x0*cos(phiA) - sta_y0*sin(phiA);
sta_BB0 = sta_x0*cos(phiB) - sta_y0*sin(phiB);

px0 = px - vx; py0 = py - vy; % adjust eq coordinates relative to volcano   
pAA0 = px0*cos(phiA) - py0*sin(phiA); % transform locs to A-A'
pBB0 = px0*cos(phiB) - py0*sin(phiB); % transform locs to B-B'



%%

    % get the topographic profiles
    % double(ZA) -> must turn ZA, the map data, into a double array
[ziA, riA, latiA, loniA] = mapprofile(double(ZA), RA, [A1.lat A2.lat], [A1.lon A2.lon]);
[ziB, riB, latiB, loniB] = mapprofile(double(ZA), RA, [B1.lat B2.lat], [B1.lon B2.lon]);

    % convert topographic profile marks to xy coordinates
[xiA,yiA] = mfwdtran(latiA,loniA); xiA = xiA - vx; yiA = yiA - vy;
[xiB,yiB] = mfwdtran(latiB,loniB); xiB = xiB - vx; yiB = yiB - vy;

%% Bottom XSection profile

xs_A = subplot(3,3,[7 8]);
pb1 = plot(yiA/1000,ziA/1000,'k'); % convert everything to km
hold on;
pb2 = plot(pAA0/1000,0,'dk','MarkerFaceColor','w');
pb3 = plot(sta_AA0/1000,0,'^k','MarkerFaceColor','k');
pb4 = scatter(AA0/1000,-Depth,eq_plot_size,DateTime); % convert AA0 to km

    % axes
% xlim([-r/1000 r/1000]); % convert axes limits to km
ylim([max_depth highest])
xlabel('Cross-Section A-A'' Dist (km)')
ylabel('Depth (km)')
% title('Cross-Section A-A''')


%% Right XSection profile
    
xs_B = subplot(3,3,[3 6]);
pr1 = plot(ziB/1000,xiB/1000,'k'); % convert to km
hold on;
pb2 = plot(0,pBB0/1000,'dk','MarkerFaceColor','w');
pb3 = plot(0,sta_BB0/1000,'^k','MarkerFaceColor','k');
pr2 = scatter(-Depth,BB0/1000,eq_plot_size,DateTime); % convert BB0 to km

    % axes
set(gca,'XDir','reverse');
xlim([max_depth highest])
% ylim([-(r/1000) r/1000]); % convert axes limits to km
xlabel('Depth (km)')
ylabel('B''-B Dist (km)')
xs_B.YAxisLocation = 'right';
xs_B.XAxisLocation = 'top';
xs_B.YDir = 'reverse';
% title('Cross-Section B-B''')

    % Lock Depth and Dist axes on B-B' with Depth and Dist axes on A-A'
xs_B.XTick = xs_A.YTick; % Depth
xs_B.XTickLabel = xs_A.YTickLabel;
xs_B.YTick = xs_A.XTick; % Dist
xs_B.YTickLabel = xs_A.XTickLabel;

set([xs_A xs_B],'Color',[0.75 0.75 0.75]); % sets the background color for the xsection to gray so that colors are visible

%% clean up the figure & print

% print(H,'-dpng','-r300',[volcname '_WingPlot.png'])

%% Internal functions

    function A = rescaleMoments( vec, R)
        % RESCALE Rescales vector quantities to a given range.
        
        % borrowed this from a post on StackOverflow
        
        A = vec;
        dR = diff( R );
        
        A =  A - min( A(:)); % set range of A between [0, inf)
        A =  A ./ max( A(:)) ; % set range of A between [0, 1]
        A =  A .* dR ; % set range of A between [0, dRange]
        A =  A + R(1); % shift range of A to R
        
    end

end