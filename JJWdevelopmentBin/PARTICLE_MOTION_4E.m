%% PARTICLE MOTION DEVELOPMENT
function PARTICLE_MOTION_4E
%{
The y1, y2, y3 may not actually match up properly. This is just to see if
I could get everything responding the way it is supposed to.


%UPDATES
SEP 22 2015: Add plot labels
SEP 22 2015: Accept actual seismic data (stub)
SEP 22 2015: Include sample rate to get indices of seismic data associated with zoom limits

%}

%% Stub data (trigometric)

t = 1:100;
z = 3*sin(t);
e = 2*cos(t);
n = -1*sin(t);


%% Stub data (seismic)

load('trace_data'); % from Iliamna, IVE_BH[Z,N,E]
t = t-min(t)+1;
sample_rate = 100;



%% Initialize Figure

f = figure;


%% Plot data

    % Define space for waveforms & plot
sp(1) = subplot(2,4,[1:3]);
plot(t,e); hold on; plot(t,n,'r'); plot(t,z,'k');
ylabel('Time');
% datetick('x','HH:MM:SS');

    % Define zoom axes and callbacks
wp_xlim = 1:length(z);
zh = zoom(sp(1));
zh.Motion = 'horizontal';
zh.ActionPostCallBack = @waveformZoom;
zh.Enable = 'on';

    % Define pan and callbacks
ph = pan(f);
ph.Motion = 'horizontal';
ph.Enable = 'on';

    % Define space for E/N particle motion & plot
sp(2) = subplot(2,3,4); plot(e(wp_xlim),n(wp_xlim));
xlabel('East'); ylabel('North');
axis square

    % Define space for E/Z particle motion & plot
sp(3) = subplot(2,3,5); plot(e(wp_xlim),z(wp_xlim));
xlabel('East'); ylabel('Vertical');
axis square

    % Define space for N/Z particle motion & plot
sp(4) = subplot(2,3,6); plot(n(wp_xlim),z(wp_xlim));
xlabel('North'); ylabel('Vertical');
axis square

%% Callback Functions

    function waveformZoom(obj, eventdata)
        
        max_data_length = length(obj.Children(4).Children(3).XData)
        % returns the x limits of the waveform panel in vector format,
        % e.g., [0 100]
        waveform_xlim = round(eventdata.Axes.XLim);
        waveform_xlim(1) = floor(waveform_xlim(1)/sample_rate)
        waveform_xlim(2) = ceil(waveform_xlim(2)/sample_rate)
        
        % return the appropriate vector length to resize the data to
        if waveform_xlim(1) < 1, waveform_xlim(1) = 1; end; % minimum position value is 1
        if waveform_xlim(2) > max_data_length, waveform_xlim(2) = max_data_length; end; % sets maximum position value
        data_range = waveform_xlim(1):waveform_xlim(2) % e.g., 1:100
        %     find(waveform_xlim(1))
        %     find(waveform_xlim(2))
        
        obj.Children(4).Children(3).XData(waveform_xlim(1))
        obj.Children(4).Children(3).XData(waveform_xlim(2))
        
        % grab the original traces from the waveform plot
        % Note: Children are numbered in the reverse order from which they
        % are added. Therefore, obj.CHILDREN(4).Children(3) represents the
        % plot of the waveform data. Then obj.Children(4).CHILDREN(3),
        % e.g., represents the first waveform trace that was plotted.
        og_e = obj.Children(4).Children(3).YData(data_range);
        og_n = obj.Children(4).Children(2).YData(data_range);
        og_z = obj.Children(4).Children(1).YData(data_range);
        
        % cuts the data from one of the particle motion axes down to the proper size
        % NOTE: obj.CHILDREN(3) represents the first particle motion plot to be added to the panel
        obj.Children(3).Children.XData = og_e; % E/N plot
        obj.Children(3).Children.YData = og_n;
        
        obj.Children(2).Children.XData = og_e; % E/Z plot
        obj.Children(2).Children.YData = og_z;
        
        obj.Children(1).Children.XData = og_n; % N/Z plot
        obj.Children(1).Children.YData = og_z;
        
    end


    function waveformPan(obj, eventdata)
        
        
    end


end