%% The problem

figure;

axh1 = subplot(311)

x1 = 0:0.01:20;
x2 = 11:0.01:30;
y1 = 200*exp(-0.05*x1).*sin(x1);
y2 = 0.8*exp(-0.5*x2).*sin(10*x2);
a = plotyy(x1,y1,x2,y2)
zoom('xon')



axh2 = subplot(312)

x1 = 0:0.01:20;
x2 = 11:0.01:30;
y1 = 200*exp(-0.05*x1).*sin(x1);
y2 = 0.8*exp(-0.5*x2).*sin(10*x2);
b = plotyy(x1,y1,x2,y2)
zoom('xon')


axh3 = subplot(313)

x1 = 0:0.01:20;
x2 = 200*exp(-0.05*x1).*cos(x1);
c = plot(x1,y1)
zoom('xon')

% linkaxes([axh1(:) axh2(:)],'x')
linkaxes([axh1 axh2 axh3],'x')

%% How it's fixed

figure;

axh1 = subplot(311)

x1 = 0:0.01:20;
x2 = 11:0.01:30;
y1 = 200*exp(-0.05*x1).*sin(x1);
y2 = 0.8*exp(-0.5*x2).*sin(10*x2);
a = plotyy(x1,y1,x2,y2)
zoom('xon')



axh2 = subplot(312)

x1 = 0:0.01:20;
x2 = 11:0.01:30;
y1 = 200*exp(-0.05*x1).*sin(x1);
y2 = 0.8*exp(-0.5*x2).*sin(10*x2);
b = plotyy(x1,y1,x2,y2)
zoom('xon')


axh3 = subplot(313)

x1 = 0:0.01:20;
x2 = 200*exp(-0.05*x1).*cos(x1);
c = plot(x1,y1)
zoom('xon')

% linkaxes([axh1(:) axh2(:)],'x')
linkaxes([a b axh3],'x')