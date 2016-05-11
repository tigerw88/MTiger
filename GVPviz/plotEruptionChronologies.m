%% plot eruption chronologies by latitude

plot_by = 'latitude';
marker_size = 20;

switch plot_by
    
    % Plot by Latitude    
    case 'latitude'
        
        
        for v = 1:numel(VOLCANO)
            
%             eruptions = VOLCANO(n).ERUPTIONS;
%             
%             colors = cell2mat(eruptions.VEI_color);
%             m = numel(colors)/3;
%             colors = reshape(colors, [m 3]);
%             
%             y = repmat(VOLCANO(n).lat, [size(eruptions.StartDatenum), 1]);
%             
%             scatter(eruptions.StartDatenum, y, marker_size, colors, 'filled')
%             
%             hold on

            TIMES = VOLCANO(v).ERUPTIONS.StartDatenum;
            VEI_Color = VOLCANO(v).ERUPTIONS.VEI_color;
            y = repmat(VOLCANO(v).lat, [size(TIMES), 1]);

            for n = 1:numel(TIMES), scatter(TIMES(n), y(n), marker_size,VEI_color{n},'filled'); hold on; end
            
            hold on;
            
        end
        
        ylabel('Latitude')
        
        
    %plot eruption chronologies alphabetically
    case 'volcano'
        
        y_value = 0;
        
        for n = 1:numel(VOLCANO)
            
            y_value = y_value - 1;
            
            eruptions = VOLCANO(n).ERUPTIONS;
            
            colors = cell2mat(eruptions.VEI_color);
            m = numel(colors)/3;
            colors = reshape(colors, [m 3]);
            
            y = repmat(abs(y_value), size(eruptions.StartDatenum), 1);
            
            scatter(eruptions.StartDatenum, y, marker_size, colors, 'filled')

            hold on
            
        end
        
        ylabel('Volcano')
        
    otherwise
        
end

datetick('x')
xlabel('year')

