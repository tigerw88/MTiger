%% Augustine2005_2006.m
%{
Personal Matlab extensions in utilization:
FFM_HISTPLOTS
-DAYFRAC2STR
-SMARTYTEXTPOS
-FILTERANNULUS
-FILTERTIME
%}

    % Initialize Volcano Settings
volc_name = 'Augustine 2005-2006';
vlat = 59.3626; vlon = -153.435;
time_zone_str = 'AKST (UTC -9h)';
time_zone_change = -9/24;
 
    % set time window for analysis
t1 = datenum('2005/01/15 00:00:00');
t2 = datenum('2006/03/31 23:59:59');
bin_size = 1/24; % n days

    % Load time-line
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Augustine/AugustineAKST-aviation.mat')
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Augustine/AugustineAKST.mat')

    % load ANSS catalog
load('catsearch.20704.mat')
catalog_s = catalog; % initialize subcatalog

FFM_HistPlots




