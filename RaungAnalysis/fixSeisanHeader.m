%% fixSeisanHeader
function fixSeisanHeader(filename)
   % Read a v7.0 or later SEISAN file
   % example file is currently :'c:\2008-05-12-0630-00S.INSN__054'
   % dataRequest has the fields dataSource, scnls, startTimes, and endTimes
   % only looks in first file, currently.
   %dataRequest.startTimes = subdivide_files_by_date(dataRequest.dataSource,dataRequest.startTimes,dataRequest.endTimes);
   %fn = getfilename(dataRequest.dataSource,dataRequest.scnls,dataRequest.startTimes);
   w  = waveform; %initialize, in case nothing works
   MACHINEFORMAT = 'l';
   %disp('Little Endian');
   %    fid = fopen(filename,'r',MACHINEFORMAT);
   fid = fopen(filename,'r+',MACHINEFORMAT); % JJW2
   bytesToRead = fread(fid,1,'uint32');
   if bytesToRead ~= 80
       fclose(fid);
       MACHINEFORMAT = 'b';
       %disp('Switching to Big Endian');
       %       fid = fopen(filename,'r',MACHINEFORMAT);
       fid = fopen(filename,'r+',MACHINEFORMAT); % JJW2
       bytesToRead = fread(fid,1,'uint32');
       if bytesToRead ~= 80
           
           warning('Waveform:load_seisan:invalidFileFormat',['File does not appear to be a SEISAN file,]'...
               '[ or is an old PC version.\n This program is currently]',...
               '[ incapable of opening PC SEISAN files older than V7.0']);
           fclose(fid);
           return
       end
   end
   
   
   fseek(fid,0,-1);
   
   nsta = 0;
   for i=1;
       bytesToRead = fread(fid,1,'uint32');
       if bytesToRead == 80
           pos = ftell(fid);
           fseek(fid, pos, -1)
           fwrite(fid,' YY   ','char')
           
       else
           break
       end
   end
   
   fclose(fid);
end

