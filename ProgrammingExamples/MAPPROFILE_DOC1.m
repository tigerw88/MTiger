%% MAPPROFILE_DOC1

load korea
h = worldmap(map, refvec); % The figure has no map content.
plat = [ 43  43  41  38];
plon = [116 120 126 128];
mapprofile(map, refvec, plat, plon)
load coast
plotm(lat, long)
geoshow('worldcities.shp', 'Marker', '.', 'Color', 'red')

