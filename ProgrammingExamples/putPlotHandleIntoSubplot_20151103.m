%% Put Plot Handle into Subplot axes

f1 = figure;

p1 = plot(0*pi/180:0.1:720*pi/180,sin(0*pi/180:0.1:720*pi/180),'r')
title('Sine wave')

f2 = figure;

s(1) = subplot(211)
p2 = plot(0*pi/180:0.1:720*pi/180,cos(0*pi/180:0.1:720*pi/180))


s(2) = subplot(212)
p3 = plot(0*pi/180:0.1:720*pi/180,cos(0*pi/180:0.1:720*pi/180))

%%

f3 = figure;

s(2) = subplot(2,1,2)
p = m201511033_testPlot;

s(1) = subplot(211)
p2 = plot(0*pi/180:0.1:720*pi/180,cos(0*pi/180:0.1:720*pi/180))








