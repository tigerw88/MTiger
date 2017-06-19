function h = histogram2( obj )
%HISTOGRAM2 Creates a histogram that also shows the percentage of
% the total that each bin represents
%
% >> histogram2( T )
%

%%

h = histogram( obj );
ax = gca;

binamts = zeros(size(h.BinEdges));
binpct = binamts;
totalamt = sum(abs(h.Data));
for n = 1:numel(binamts)-1
    
    binamts(n) = sum(abs(h.Data(h.Data>=h.BinEdges(n) & h.Data < h.BinEdges(n+1))));
    binpct(n) = binamts(n) / totalamt;
        
end


ax2 = axes();
ax2.Position = ax.Position;
plot(ax2, h.BinEdges, cumsum(binpct), '-r')
ax2.Color = 'None';
ax2.YAxisLocation = 'right';
ylabel('Cumulative % of Total Amount per Bin')
ax2.YTickLabel = ax2.YTick * 100;

% legend('Cumulative %')

end

