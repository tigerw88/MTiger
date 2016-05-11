% debug_series2period_1

figure;

plot([back_windows(:,1) back_windows(:,1)],[0 1],'k:'), hold on
plot([back_windows(:,2) back_windows(:,2)],[0 1],'k--')
plot(baddata,0.5,'sk')
good_windows = series2periodB(back_windows, baddata, 1, 'exclude');
plot([back_windows(:,1) back_windows(:,1)],[1 2],'r:'), hold on
plot([back_windows(:,2) back_windows(:,2)],[1 2],'r--')