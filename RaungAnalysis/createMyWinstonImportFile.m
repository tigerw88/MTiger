%% create a bash file that will import all of my SEISAN data

importcommand = '/Users/jaywellik/winston-1.3.0-SNAPSHOT/bin/ImportSeisan.sh';
winston_scnl = 'MLLR$EHZ$RC';
unzipped_dir= '/Volumes/RaungBackup/RaungSeisan';
years=2015;
months=6:7;
dates=1:31;

for y = 1:numel(years)
    for m = 1:numel(months)
        
        % unzip the directory
        % e.g., unzip /Volumes/RaungBackup/RaungSeisan/2013/2013_02.zip -d /Volumes/RaungBackup/RaungSeisan/2013/
        fprintf('unzip %s/%d/%d_%02d.zip -d %s/%d\n', unzipped_dir, years(y), years(y), months(m), unzipped_dir, years(y))
        
        
        for d = 1:numel(dates)

                % print the import command
                % e.g., /Users/jaywellik/winston-1.3.0-SNAPSHOT/bin/ImportSeisan.sh -c 'KBUR$EHZ$RC' /Volumes/RaungBackup/RaungSeisan/2013/2013_01/20130103/Set00/*
%             fprintf('%s -c ''%s'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, winston_scnl, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));

                % print the import command not using smart scnls
%             fprintf('%s -c ''MLLR$EHZ$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
%             fprintf('%s -c ''MLLR$EHE$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
%             fprintf('%s -c ''MLLR$EHN$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
            fprintf('%s -c ''KBUR$EHZ$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
%             fprintf('%s -c ''RAUN$EHZ$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));
%             fprintf('%s -c ''POSR$EHZ$RC'' %s/%d/%d_%02d/%d%02d%02d/Set00/* \n', importcommand, unzipped_dir, years(y), years(y), months(m), years(y), months(m), dates(d));

        end

            % remove the unzipped directory
            % e.g., rm -R /Volumes/RaungBackup/RaungSeisan/2013/2013_12/
        fprintf('rm -R %s/%d/%d_%02d/ \n', unzipped_dir, years(y), years(y), months(m))
        
    end
end

