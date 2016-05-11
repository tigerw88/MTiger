%% testing wingplot2A

% load('/Users/jwellik/Documents/MATLAB/JJWdevelopmentBin/wingplot2A/wingplot2A_devvars.mat')

wp = wingplot2A()

wp = wingplot2A(wp,'scatter',elon,elat,-z,Moment,DateTime)
wp = wingplot2A(wp,'plot',vlon,vlat,[],'^k','MarkerFaceColor','w')
wp = wingplot2A(wp,'plot',longann,latann,[],'k','LineWidth',2,'LineStyle',':')
wp = wingplot2A(wp,'plot',vcoords(:,2),vcoords(:,1),[],'^k','MarkerFaceColor','w');
wp = wingplot2A(wp,'magbox');

wp = wingplot2A(wp,'depthlim',[-35 0])
wp.Map.YLim = [52.5 54.25]; wp.Map.XLim = [-169 -167.25];
wp = wingplot2A(wp,'title',{vname; [datestr(DateTime(1)) ' to ' datestr(DateTime(end))]})
