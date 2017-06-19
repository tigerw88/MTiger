function fh = multiplot( w, varargin )

fh = figure('Position', [100, 100, 1000, 525]);
fh.PaperPositionMode = 'auto';

pltn = -1;
for n = 1:numel(w)
    
    pltn = pltn + 2;
    ax(n) = subplot(numel(w),2,pltn);
    plot(w(n), 'xunit', 'date', varargin{:})
    
    
    td = TraceData(w(n));
    td = td.fillgaps('interp');
    [pxx, ~, f] = td.amplitude_spectrum;
    %    [pxx,f] = pwelch(get(w(n),'data'),[],[],256,get(w(n),'freq'),'centered','power'); % compute power spectra
    pxx = pxx(f>0.1); % grab power spectra for positive frequencies only
    f = f(f>0.1); % grab only positive frequencies
    specax(n) = subplot(numel(w),2,pltn+1);
    plot(f, pxx, 'k', 'LineWidth', 0.8)
    
end

linkaxes(ax,'x')

end