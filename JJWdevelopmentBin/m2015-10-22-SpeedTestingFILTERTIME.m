clc

t1 = '2004/01/01 00:00:00';
t2 = '2004/12/31 00:00:00';

tic, catalog_r = filterTime(catalog,t1,t2); toc


tic, times = datenum(extractfield(catalog,'DateTime')); toc
tic, id_t = find(times > datenum(t1) & times < datenum(t2)); toc
tic, catalog_r = catalog(id_t); toc

t1d = datenum(t1);
t2d = datenum(t2);

tic, id_t = find(times > t1d & times < t2d); toc
tic, catalog_r = catalog(id_t); toc

% RESULTS:
%{
There is a lot of overhead in the FILTERTIME function because of the
intensivity of EXTRACTFIELD, which is used inside FILTERTIME.
%}
