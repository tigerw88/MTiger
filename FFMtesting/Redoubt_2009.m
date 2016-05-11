%% Redoubt_2009.m
%{
Personal Matlab extensions in utilization:
FFM_HISTPLOTS
-DAYFRAC2STR
-SMARTYTEXTPOS
-FILTERANNULUS
-FILTERTIME
%}

    % Initialize Volcano Settings
volc_name = 'Redoubt 2009';
vlat = 60.4852; vlon = -152.7438;
time_zone_str = 'AKDT (UTC -8h)';
time_zone_change = -8/24;
 
    % set time window for analysis
t1 = datenum('2008/06/20 00:00:00');
t2 = datenum('2009/05/15 23:59:59');
bin_size = 1; % n days

    % Load time-line
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Redoubt2009/redoubtAKDT.mat')
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Redoubt2009/redoubtAKDT-aviation.mat')

    % load ANSS catalog
load('catsearch.20704.mat')
catalog_s = catalog; % initialize subcatalog

FFM_HistPlots