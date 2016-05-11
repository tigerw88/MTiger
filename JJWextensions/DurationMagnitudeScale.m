%% Duration Magnitude Scale

plot(1:1:5*60,duration2magnitude(1:1:5*60),'k-','LineWidth',2)
ax = gca;
ax.XTick = (0:15:5*60)
ax.XTickLabel(1:end) = {' '};
ax.XTickLabel(1:60/15:end) = cellstr(strsplit(num2str(0:5),' ')); % ax.XTickLabel
ax.YTick = 0:0.2:5
ax.YTick = -2:.5:5
ax.YTick = -3:.5:5
ax.YGrid = 'on'
ax.XGrid = 'on'
% ax.XMinorGrid = 'on';
ax.XLabel.String = 'Duration (Minutes)'
ax.YLabel.String = 'Magnitude'

%% This might be of use

cellstr(strsplit(num2str([nan,nan,nan]),' ')) % ax.XTickLabel
ans(strcmp(ans,'NaN')) = {' '};