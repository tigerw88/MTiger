%% Raung - Day Long Helicorder Plots - from SAC files
% Looks like this doesn't do anything right now. Use
% BuildHelicordersFromSAC.m instead

sacdir = '/Volumes/RaungBackup/RaungSAC'

scnl = scnlobject('KBUR','EHZ','RC','--');

year_list = dir([sacdir '/2014']);

for n = 1
    
    month_list = dir([sacdir '/' year_list(n).name '/*.zip']);
    
    for m = 1:length(month_list)
        
        zipdir = fullfile(sacdir,year_list(n).name);
        zipfile = fullfile(zipdir,month_list(m).name);
%         tic; system('unzip /Volumes/RaungBackup/RaungSAC/2012/201211.zip -d /Volumes/RaungBackup/RaungSAC/2012/'); toc
        tic; system(['unzip ' zipfile ' -d ' zipdir]); toc
        unzipped = strsplit(zipfile,'.zip'); unzipped = unzipped{1};
        
        min_list = dir([unzipped '/*MAN*'])
        
        for min = 1:length(min_list)
            
            filename = [unzipped '/' min_list(min).name '/' get(scnl,'station') '.' get(scnl,'channel') '.' get(scnl,'network') '.' get(scnl,'location')];
            ds = datasource('sac',filename);
            w(min) = waveform(ds, scnl, '2010/01/01', '2016/03/01'); % these dates effectively allow you to grab everything
            
        end
        
        
    end
    
end