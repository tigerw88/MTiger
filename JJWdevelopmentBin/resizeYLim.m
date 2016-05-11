function resizeYLim( ax )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

orig_ylim = ax.YLim
new_ylim = [ 0 0 ]

new_xdata = [];
new_ydata = [];

for n = 1:length(ax.Children)

    ch = ax.Children(n);
    if isprop(ch,'XData')
        new_xdata = ch.XData >= ax.XLim(1) & ch.XData <= ax.XLim(2);
        new_ydata = [new_ydata ch.YData(new_xdata)];
%         if min(new_ydata) < new_ylim(1), new_ylim(1) = min(new_ydata), end;
%         if max(new_ydata) > new_ylim(2), new_ylim(2) = max(new_ydata), end;
    end
end

disp([num2str(min(new_ydata)) ' - ' num2str(max(new_ydata))]);
ax.YLim = [min(new_ydata) 1.1*max(new_ydata)];

end

