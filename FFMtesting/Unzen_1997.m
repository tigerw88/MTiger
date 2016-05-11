%% Unzen_1997
%{
Personal Matlab extensions in utilization:
FFM_HISTPLOTS
-DAYFRAC2STR
-SMARTYTEXTPOS
-FILTERANNULUS
-FILTERTIME
%}

    % Initialize Volcano Settings
volc_name = 'Unzen 1997';
vlat = 32.7156; vlon = 130.1766; % stub location
time_zone_str = 'Time (UTC -0h)';
time_zone_change = -0/24;
 
    % set time window for analysis
t1 = datenum('1985/01/01 00:00:00');
t2 = datenum('1997/12/31 23:59:59');
bin_size = 1; % n days

    % Load time-line & colorcodes
% load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Redoubt2009/redoubtAKDT.mat')
% load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Redoubt2009/redoubtAKDT-aviation.mat')

    % load catalog
load('/Users/jwellik/Documents/JAY-VDAP/unzenpapers-fromWendy/unzenCatalogFromWendy.mat')
catalog_s = catalog; % initialize subcatalog

FFM_HistPlots

title({'Unzen 1997';'Unzen Catalog - Bin Size: 1 day'}) % change the title
