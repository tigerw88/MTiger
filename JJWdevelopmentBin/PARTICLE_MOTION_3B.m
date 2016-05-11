%% PARTICLE_MOTION_B2.m
function PARTICLE_MOTION_B2

%% Stub data

global z
global e
global n

x = 1:100;
z = sin(x); e = cos(x); n = -sin(x);


%% Initialize Figure

f = figure;




%% Plot data


    % Define space for waveforms & plot
sp(1) = subplot(2,4,[1:3]);
plot(x,z); hold on; plot(x,e,'k'); plot(x,n,'r');

    % Define zoom axes and callbacks
waveform_xlim = 1:length(z);
zh = zoom(sp(1));
zh.Motion = 'horizontal';
zh.ActionPostCallBack = @waveformZoom;
zh.Enable = 'on';


plotParticleMotion(waveform_xlim);



    function plotParticleMotion(data_range)
            
        % Define space for N/E particle motion & plot
    subplot(2,3,4); plot(e(data_range),n(data_range));
    axis square

        % Define space for Z/E particle motion & plot
    subplot(2,3,5); plot(e(data_range),z(data_range));
    axis square

        % Define space for Z/N particle motion & plot
    subplot(2,3,6); plot(n(data_range),z(data_range));
    axis square


    end




%% Callback Functions


function waveformZoom(~, eventdata)

     
        % returns the x limits of the waveform panel in vector format,
        % e.g., [0 100]
    waveform_x_limits = round(eventdata.Axes.XLim)
   
    subplot(2,3,4); plot(sin(1:100),cos(1:100))
    axis equal
    
    
    
end

end