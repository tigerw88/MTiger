function [wp, props] = wingplot2A( varargin )

if nargin == 0
    
    wp = genericWingPlot();
    
else
    
%     props = parseargs(varargin(3:end))
%     whos(props)
    
    wp = varargin{1}; % assumes that the first input variable is an existing wing plot    
%     whos('wp'); v = varargin{2}; whos('v'); % trouble shooting lines
    
    switch lower(varargin{2}) % assumes that the second input variable tells you what you want to do next
        
        case 'plot'
            
            lat = varargin{4}; lon = varargin{3}; depth = varargin{5};
            if isempty(depth), depth(size(lat)) = zeros; end
            
%             whos('lat','lon','depth','style'); % trouble shooting lines
            
            plot(wp.Map, lon, lat, varargin{6:end});
            plot(wp.BottomXSec, lon, depth, varargin{6:end});
            plot(wp.RightXSec, depth, lat, varargin{6:end});
            
            linkaxes([wp.Map, wp.BottomXSec],'x');
            linkaxes([wp.Map, wp.RightXSec],'y');
            
        case 'scatter'
            
            lat = varargin{4}; lon = varargin{3}; depth = varargin{5};
            marker_size = rescaleMomentsForPlot(varargin{6}, [5 100]);
%             max(marker_size) min(marker_size)
            color = varargin{7};
            if nargin < 7, error('Sorry, scatter wingplots must take in lat, lon, depth, size, and color parameters'); end
            
            colormap('jet')
            scatter(wp.Map, lon, lat, marker_size, color);
                   
            scatter(wp.BottomXSec, lon, depth, marker_size, color);
            scatter(wp.RightXSec, depth, lat, marker_size, color);
%             caxis([min(color) max(color)])

%             hcb=colorbar;
%             hcb.Location = 'westoutside';
            
%             addColorBar(color);

            linkaxes([wp.Map, wp.BottomXSec],'x')
            linkaxes([wp.Map, wp.RightXSec],'y')
            
        case 'topography'
            
            addTopography2Map();
            drawXSections();
            
        case 'xsecangle'
            
        case 'magbox'
            
            % this is just stub stuff right now. There is no connection
            % between these data and sizes with the actual data.
            
            minMag = 0; maxMag = 6;
            plot_size = [5; 10; 20; 40; 80; 160; 320];
            inc = 1;
            
            for n = minMag:inc:maxMag
                
                scatter(wp.Info,1,n,plot_size(n+1),'k'); hold on;
                text(2,n,['M ' num2str(n)],'FontName','Calibri','FontSize',12);
                
            end
            
            wp.Info.XLim = [0 5];
            wp.Info.YLim = [minMag-1 maxMag+1];
            wp.Info.Color = 'none';
            wp.Info.XColor = 'none';
            wp.Info.YColor = 'none';
                        
        case 'bvalue'
            
        case 'depthlim'
            
            dlim = varargin{3};
     
                % sometimes the user might give the depth limits as [0
                % -35]; correct for this if it happens
            if dlim(1) > dlim(2), tmp_dlim = dlim; dlim(1) = tmp_dlim(2); dlim(2) = tmp_dlim(1); clear tmp_dlim; end
            
            wp.BottomXSec.YLim = dlim;
            wp.RightXSec.XLim = dlim;
            
        case 'latlim'
            
        case 'lonlim'
            
        case 'eastlim'
            
        case 'northlim'
            
        case 'gshhs'
            
            % WARNING: This feature is not yet functional
            % NOTE: This feature relies on the Matlab Mapping Toolbox feature
            % >> wp = wingplot2A(wp,'gshhs', settings.GSHHSf, lonlim, latlim, 'k'); % plot coastlines
            
            if exist('gshhs') % 
                
                latlim = varargin{5}; lonlim = varargin{4};
            
            % coastline database - full res
            indexname = gshhs( varargin{3}, 'createindex');
            coastlines = gshhs( varargin{3}, latlim, lonlim); % coastlines is a structure
            delete(indexname)
            
            for n = 1:length(coastlines)
                
               plot(wp.Map, coastlines(n).Lon, coastlines(n).Lat, varargin{6:endf}); hold on;
                
            end
            
            else
                
                display('wingplot does not have access to the Mapping Toolbox :-(');
                
            end
        
        case 'title'
            
            wp.Map.Title.String = varargin{3};
    
            
        otherwise
            
            error('wingplot did not understand your command.')
            
    end
    
end



        % create generic WingPlot
    function dwp = genericWingPlot()
        
        Map = subplot(3,3,[1 2 4 5]);
        BottomXSec = subplot(3,3,[7 8]);
        RightXSec = subplot(3,3,[3 6]);
        Info = subplot(3,3,9);
        
        Map.Box = 'on';
        BottomXSec.Box = 'on';
        RightXSec.Box = 'on';
        Info.Visible = 'off';
        
        RightXSec.XDir = 'reverse';
        RightXSec.XLim = [-50 10];
        RightXSec.YAxisLocation = 'right';
        BottomXSec.YLim = [-50 10];
        
        Map.NextPlot = 'add';
        BottomXSec.NextPlot = 'add';
        RightXSec.NextPlot = 'add';
        
        Map.Title.String = {'Default Wing Plot';'This is a default Wing Plot that is awesome.'};
        
%         linkaxes([Map,BottomXSec],'x');
%         linkaxes([Map,RightXSec],'y');
        
        dwp.Map = Map;
        dwp.BottomXSec = BottomXSec;
        dwp.RightXSec = RightXSec;
        dwp.Info = Info;
%         dwp.ColorBar = ColorBar;
        dwp.Title = Map.Title.String;
        
%         dwp = class(dwp, 'wingplot2A');
        
    end

    function A = rescaleMomentsForPlot( vec, R)
        % RESCALE Rescales vector quantities to a given range.
        
        % borrowed this from a post on StackOverflow
        
        A = vec;
        dR = diff( R );
        
        A =  A - min( A(:)); % set range of A between [0, inf)
        A =  A ./ max( A(:)) ; % set range of A between [0, 1]
        A =  A .* dR ; % set range of A between [0, dRange]
        A =  A + R(1); % shift range of A to R
        
    end

    function w = addColorBar(w, color)


        
    end
end