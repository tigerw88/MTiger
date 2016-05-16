%% Fix Ijen Seisan Data
% Read in Ijen Post Seisan files, fix the header and write out a sac file
% 2014 April 06

%%

baseoutdirectory = '/Volumes/EFIS_seis/SEISMICDATA/Indonesia/IjenData_2011-2015/';

%%

tic

year = 2011;
month_mmm = {'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November', 'Desember'}; % all
month_mm = 1:12;
day = 1:31;

for yyyy = year
    for mmm = 1:12 % specify the month number to process here
        for dd = day
            
                % this only works if all months are processed
%             findirectory = sprintf('/Volumes/Elements/%04d/%s/%04d%02d%02d/Set00/',yyyy, month_mmm{mmm}, yyyy, month_mm(mmm), dd);
            findirectory = sprintf('/Volumes/Elements/%04d/%s/',yyyy, month_mmm{mmm}); % format for 2011
            fnames = dir([findirectory num2str(yyyy) '*']);
            
%             baseoutdirectory = '/Volumes/IjenSACconversions/';
%             mkdir(baseoutdirectory)
            
            for n = 1:numel(fnames);
                
                w = load_seisan2( fullfile(findirectory, fnames(n).name) );
                
                if ~isempty(w)
                    for j = 1:numel(w)
                        
                        w(j) = set(w(j),'network','IC');
                        tag = get(w(j),'ChannelTag');
                        startdv = datevec(get(w(j),'start'));
                        foutdirectory = sprintf('%s%04d/%04d%02d/%04d%02d%02d/',baseoutdirectory, startdv(1), startdv(1), startdv(2), startdv(1), startdv(2), startdv(3));
                        mkdir(foutdirectory);
                        savesac2(w(j), foutdirectory, [tag.string '.' fnames(n).name]);
                        
                    end
                end
                
            end
            
        end % day
    end % month
end % year
toc

