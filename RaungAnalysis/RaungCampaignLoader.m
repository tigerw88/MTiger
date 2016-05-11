function w = RaungCampaignLoader()
% RAUNGCAMPAIGNLOADER Loads Seisan files downloaded from the Raung & Ijen posts
% This script is designed specifically to load Seisan files downloaded from
% the Ruang and Ijen posts. It requires that all of the data folders are
% already unzipped. 

%% Deal with the fact that Ijen Post files are in folders with the mmm in Bahasa Indonesia

switch month
    
    case 1
        
        month_str = 'Januari';
        
    case 2
        
        month_str = 'Februari';
        
    case 3
        
        month_str = 'Maret';
        
    case 4
        
        month_str = 'April';
        
    case 5
        
        month_str = 'Mei';
        
    case 6
        
        month_str = 'Juni';
        
    case 7
        
        month_str = 'Juli';
        
    case 8
        
        month_str = 'August';
        
    case 9
        
        month_str = 'September';
        
    case 10
        
        month_str = 'Oktober';
        
    case 11
        
        month_str = 'November';
        
    case 12
        
        month_str = 'Desember';
        
    otherwise
end

%%


end