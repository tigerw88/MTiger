%% PARTICLE MOTION DEVELOPMENT
function PARTICLE_MOTION_4D1
% The y1, y2, y3 may not actually match up properly. This is just to see if
% I could get everything responding the way it is supposed to.


%% Stub data


x = 1:100;
y1 = sin(x); y2 = cos(x); y3 = -2*sin(x);


%% Initialize Figure


f = figure;


%% Plot data


    % Define space for waveforms & plot
sp(1) = subplot(2,4,[1:3]);
plot(x,y1); hold on; plot(x,y2,'k'); plot(x,y3,'r');

    % Define zoom axes and callbacks
wp_xlim = 1:length(y1);
zh = zoom(sp(1));
zh.Motion = 'horizontal';
zh.ActionPostCallBack = @waveformZoom;
zh.Enable = 'on';

    % Define space for N/E particle motion & plot
sp(2) = subplot(2,3,4); plot(y1(wp_xlim),y2(wp_xlim));
axis square

    % Define space for Z/E particle motion & plot
sp(3) = subplot(2,3,5); plot(y1(wp_xlim),y3(wp_xlim));
axis square

    % Define space for Z/N particle motion & plot
sp(4) = subplot(2,3,6); plot(y2(wp_xlim),y3(wp_xlim));
axis square

%% Callback Functions


function waveformZoom(obj, eventdata)
    
    max_data_length = length(obj.Children(4).Children(3).XData)
        % returns the x limits of the waveform panel in vector format,
        % e.g., [0 100]
    waveform_xlim = round(eventdata.Axes.XLim)
    
        % return the appropriate vector length to resize the data to
    if waveform_xlim(1) < 1, waveform_xlim(1) = 1; end; % minimum position value is 1
    if waveform_xlim(2) > max_data_length, waveform_xlim(2) = max_data_length; end; % sets maximum position value
    data_range = waveform_xlim(1):waveform_xlim(2) % e.g., 1:100

        % grab the original traces from the waveform plot
        % Note: Children are numbered in the reverse order from which they
        % are added. Therefore, obj.CHILDREN(4).Children(3) represents the
        % plot of the waveform data. Then obj.Children(4).CHILDREN(3),
        % e.g., represents the first waveform trace that was plotted.
    og_y1 = obj.Children(4).Children(3).YData(data_range);
    og_y2 = obj.Children(4).Children(2).YData(data_range);
    og_y3 = obj.Children(4).Children(1).YData(data_range);
    
    
    
        % cuts the data from one of the particle motion axes down to the
        % proper size
        % NOTE: obj.CHILDREN(3) represents the first particle motion plot
        % to be added to the panel
    obj.Children(3).Children.XData = og_y2; % North/East plot
    obj.Children(3).Children.YData = og_y3;

    obj.Children(2).Children.XData = og_y1; % Vertical/East plot
    obj.Children(2).Children.YData = og_y3;
    
    obj.Children(1).Children.XData = og_y1; % Vertical/North plot
    obj.Children(1).Children.YData = og_y2;
    
end

end