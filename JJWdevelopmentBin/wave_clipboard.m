function wave_clipboard( w )

f = figure;
nwaves = numel(w);

winheight = 0.8 / nwaves;

for n = 1:nwaves
    
    ax(n) = subplot(nwaves,1,n);
    plot(w(n), 'LineWidth', 2, 'Color', 'k')
    
    if n ~= nwaves, ax(n).XTickLabel = ''; end;
    if n ~= nwaves, ax(n).XLabel = []; end;
    ax(n).Position(4) = winheight;
    txtboxheight = 0.03;
    annotation('textbox',...
        [ax(n).Position(1)+0.005 ax(n).Position(2)+winheight-txtboxheight-0.005 0.025 txtboxheight],...
        'String',string(get(w(n),'ChannelTag')),...
        'FitBoxToText','on','Color','k','BackgroundColor','w',...
        'FontWeight','bold')
    ax(n).Title = [];
    
end

zoom('xon')
linkaxes(ax,'x');

end