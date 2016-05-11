%% handle function inputs

load('/Users/jwellik/Documents/MATLAB/JJWdevelopmentBin/helicorder_dev/stubA.mat')

nlines = length(wo)
if nlines < 24, nlines = 24, end
nlines = 24

%%

H = figure;

    % setup the plot windows
for n = 1:nlines
    
    tw(n) = subplot(nlines, 1, n)
    
    tw(n).XLim = [1 100]
    tw(n).YTick = []
    tw(n).XTick = []
    
end

% tw(1:end).Xlim = [0 10]

%% Example stuff that will not be part of final code
%%

a = subplot(3,3,[1 2 4 5])
b = subplot(3,3,[7 8])
c = subplot(3,3,[3 6])
d = subplot(3,3,9)

H.Units = 'centimeters'
a.Units = 'centimeters'
b.Units = 'centimeters'
c.Units = 'centimeters'
d.Units = 'centimeters'



gap = 1.5
a.Position = [2.75 8.5 10.5 10.5]
b.Position = [a.Position(1) 2.00 a.Position(3) 5]
c.Position = [a.Position(1)+a.Position(3)+gap a.Position(2) b.Position(4) b.Position(3)]
d.Position = [c.Position(1) b.Position(2) c.Position(3) b.Position(4)]

H.Resize = 'off'
H.Position = [50 20 25 21]

plot(a,elon,elat,'or')
plot(b,elon,Depth,'or')
b.XLabel.String = 'A-A'' Dist (km)'
b.YDir = 'reverse';
plot(c,Depth,elat,'or')





disp('--------')
for n = [a b c d]
    
    n.FontName = 'Calibri'
    n.FontSize = 12
    
end
disp('--------')


%% Create Magnitude Legend

minMag = 0; maxMag = 6;
plot_size = [5; 10; 20; 40; 80; 160; 320]
inc = 1;

for n = minMag:inc:maxMag
    
    scatter(d,1,n,plot_size(n+1),'k'); hold on;
    text(2,n,['M ' num2str(n)],'FontName','Calibri','FontSize',12)

end

d.XLim = [0 5]
d.YLim = [minMag-1 maxMag+1]
d.Color = 'none'
d.XColor = 'none'
d.YColor = 'none'


e = colorbar;
e.Units = 'centimeters';
e.Position = [a.Position(1)+a.Position(3)+gap+c.Position(3)+gap b.Position(2) 0.5 b.Position(4)+gap+a.Position(4)]
