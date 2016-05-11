%% GVP visualizations for Sarah

all_textfiles = {'Andesite.txt'; 'Basalt.txt'; 'DaciteRhyolite.txt'; 'Rhyolite.txt'; 'AndesiteRhyolite.txt'};

for n = 1:length(all_textfiles)
    
   textfile = all_textfiles{n};
   
   importGVPqueryFromSarah2A
   parseGVPquery2A
   
   scrsz = get(groot,'ScreenSize');
   figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
   plotEruptionChronologies
   ax = gca;
   xlim([datenum(1450,1,1) datenum(2015,1,1)])
%    ax.XTick([datenum(1500,1,1) datenum(1800,1,1) datenum(1900,1,1) datenum(2000,1,1)])
   
   
   fig_title = strsplit(textfile,'.txt');
   fig_title = fig_title{1};
   title(strsplit(textfile,'.txt'))
   
   
   savefig(['/Users/jaywellik/Dropbox/JAY-VDAP/GVP_viz/' fig_title '.fig'])
   print(['/Users/jaywellik/Dropbox/JAY-VDAP/GVP_viz/' fig_title '.png'],'-dpng')

   clearvars -except all_textfiles f
   
end