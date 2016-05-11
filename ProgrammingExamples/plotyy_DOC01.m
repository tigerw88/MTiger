x = linspace(0,10);
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
y3 = 0.2*exp(-0.5*x).*sin(10*x);
figure
[hAx,hLine1,hLine2] = plotyy(x,y1,[x',x'],[y2',y3']);

hLine2(1).LineStyle = 'none';
hLine2(1).Marker = '.';
hLine2(1).Color = 'k';

hLine2(2).LineStyle = 'none';
hLine2(2).Marker = 'o';
hLine2(2).Color = 'r';