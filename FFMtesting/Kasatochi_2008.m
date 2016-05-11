%% Kasatochi_2008.m
%{
Personal Matlab extensions in utilization:
FFM_HISTPLOTS
-DAYFRAC2STR
-SMARTYTEXTPOS
-FILTERANNULUS
-FILTERTIME
%}

    % Initialize Volcano Settings
volc_name = 'Kastochi 2008';
vlat = 52.1693; vlon = -175.5113;
time_zone_str = 'AKDT (UTC -8h)';
time_zone_change = -8/24;
 
    % set time window for analysis
t1 = datenum('2008/07/20 00:00:00');
t2 = datenum('2008/08/15 23:59:59');
bin_size = 1/24; % n days

    % Load time-line
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Kasatochi2008/kasatochiAKDT.mat')
load('/Users/jwellik/Documents/JAY-VDAP/FFMtesting/Kasatochi2008/kasatochiAKDT-aviation.mat')

    % load ANSS catalog
load('catsearch.20704.mat')
catalog_s = catalog; % initialize subcatalog

FFM_HistPlots




