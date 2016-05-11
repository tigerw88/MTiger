function [ ax, new_ax ] = addWarningLevelToPlotFFM1A( ax, times, warning_level, varargin )
%ADDWARNINGLEVELTOPLOT Adds a bar with the warning level color codes to the
%top of a pre-existing plot.
%   Detailed explanation goes here

%{
varargin options could be:

'Location' : { ('top') | 'bottom' }
'Type' : { ('4 step generic') | 'AVO' | 'AVO Aviation' | 'CVO' | 'PVMBG' }
'height' : the height of the color code bar as a percentage of the original
plot's original height - e.g., 1/8 or 0.125 (default: 0.1)
%}

% NOTES & UPDATES
%{
Dec 17, 2015 - Currently not set up to handle varargin


%}

% Author: Jay Wellik, USGS-VDAP, jwellik <at> usgs.gov
% Created: Dec 17, 2015

%% Define Defaults

new_plot_height = 0.1;



%% Parse varargin



%%

f = ax.Parent; % get the handle for the correct figure

    % define new y-values and heights for the original axis
original.h1 = ax.Position(4); % initial height of first plot
original.y1 = ax.Position(2); % initial y value of first plot axis
original.h2 = original.h1 * (1 - new_plot_height); % second height of original plot
original.top1 = original.y1 + original.h1; % the initial top value for the original plot
original.top2 = original.y1 + original.h2; % second top value for original plot

    % define y-values and height for new axis
new.y = original.y1 + original.h2;
new.h = original.top1 - original.top2;
ax.Position(4) = original.h2;

%%
    % create the new axis
figure(f); % ensure that the correct figure is present
new_ax = axes('Position',[ax.Position(1) new.y, ax.Position(3) new.h]); % set the position

%%
% 
%     % plot the color code warnings
% new_plot = plot(new_ax, times, warning_level)
%
%%

    % plot aviation color codes for background
if exist('colorcode','var')
    
    for n = 1:length(colorcode.color)-1
        
        rectangle(new_ax,'Position',[colorcode.timeline(n) 0,...
            colorcode.timeline(n+1)-colorcode.timeline(n) 1],...
            'FaceColor',colorcode.color{n}); hold on;
        
    end
    rectangle(new_ax,'Position',[colorcode.timeline(end) 0 100 1],'FaceColor',colorcode.color{end}); hold on;
    
end



%%

    % link axes and define zoom properties
new_ax.YTick = [];
new_ax.XTick  = [];
linkaxes([ax new_ax],'x')
zoom(ax.Parent,'xon')

end