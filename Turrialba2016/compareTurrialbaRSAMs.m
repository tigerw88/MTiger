%% compareTurrialbaRSAMs

W = fix_data_length([vtcg, vica, vimo]);

for n = 1:numel(W)-1
    
   data1 = get(W(n), 'data');
   data2 = get(W(n+1), 'data');
   RATIO(n) = W(n); RATIO(n) = set(RATIO(n), 'data', (data1./data2)./data1);
    
end

ratio(1,:) = (get(W(1), 'data') ./ get(W(2), 'data')) ./ get(W(1), 'data'); RATIO(1) = W(1); RATIO(1) = set(RATIO(1), 'data', ratio(1,:));
ratio(2,:) = (get(W(1), 'data') ./ get(W(3), 'data')) ./ get(W(1), 'data'); RATIO(2) = W(2); RATIO(2) = set(RATIO(2), 'data', ratio(2,:));
ratio(3,:) = (get(W(2), 'data') ./ get(W(3), 'data')) ./ get(W(2), 'data'); RATIO(3) = W(3); RATIO(3) = set(RATIO(3), 'data', ratio(3,:));

figure
for n = 1:length(W)
    ax(n) = subplot(numel(W),1,n); plot(W(n), 'xunit', 'date')
end
linkaxes(ax,'x')

figure
nplots = numel(RATIO)+1;
for n = 1:numel(RATIO)
      
   subplot(nplots,1,n)
   plot(W(1))
   subplot(nplots,1,n+1)
   plot(RATIO(n))
    
end



