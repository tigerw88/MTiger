function p = m201511033_testPlot
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p(1) = plot(0*pi/180:0.1:720*pi/180,sin(0*pi/180:0.1:720*pi/180),'r'), hold on
p(2) = plot(0*pi/180:0.1:720*pi/180,cos(0*pi/180:0.1:720*pi/180),'k')
title('Sine Wave')
xlabel('Pi')
ylabel('y')

end

