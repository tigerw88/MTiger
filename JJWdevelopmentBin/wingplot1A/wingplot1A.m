%% Load stub data

% load('wingPlot_2A_devvars.mat')
elon = elong;

% UPDATES:
%{
2015-Oct-23: Attempting to convert panel sizes from 'centimeters' to
'normalized'.


%}

%% Starting plotting routine

H = figure;

a = subplot(3,3,[1 2 4 5])
b = subplot(3,3,[7 8])
c = subplot(3,3,[3 6])
d = subplot(3,3,9)

H.Units = 'centimeters'
% a.Units = 'centimeters'
% b.Units = 'centimeters'
% c.Units = 'centimeters'
% d.Units = 'centimeters'

H.Resize = 'on'
H.Position = [50 20 25 21]


% gap = 1.5
% a.Position = [2.75 8.5 10.5 10.5]
% b.Position = [a.Position(1) 2.00 a.Position(3) 5]
% c.Position = [a.Position(1)+a.Position(3)+gap a.Position(2) b.Position(4) b.Position(3)]
% d.Position = [c.Position(1) b.Position(2) c.Position(3) b.Position(4)]


% a.Units = 'normalized'
% b.Units = 'normalized'
% c.Units = 'normalized'
% d.Units = 'normalized'
% 
% ssize = 20;
% gap = 1.5/ssize
% a.Position = [2.75/ssize 8.5/ssize 10.5/ssize 10.5/ssize]
% b.Position = [a.Position(1) 2.00/ssize a.Position(3) 5/ssize]
% c.Position = [a.Position(1)+a.Position(3)+gap a.Position(2) b.Position(4) b.Position(3)]
% d.Position = [c.Position(1) b.Position(2) c.Position(3) b.Position(4)]

a.Units = 'normalized'
b.Units = 'normalized'
c.Units = 'normalized'
d.Units = 'normalized'

ssize = H.Position(4);
gap = 1.5/ssize
a.Position = [0.09 8.5/ssize 0.48 0.48]
b.Position = [a.Position(1) 3.00/ssize a.Position(3) 4/ssize]
c.Position = [a.Position(1)+a.Position(3)+gap a.Position(2) b.Position(4) b.Position(3)]
d.Position = [c.Position(1) b.Position(2) c.Position(3) b.Position(4)]


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
e.Units = 'normalized';
e.Position = [a.Position(1)+a.Position(3)+gap+c.Position(3)+gap/2 b.Position(2) 0.5/ssize b.Position(4)+gap+a.Position(4)]
