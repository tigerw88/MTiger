function PARTICLE_MOTION_C1


t = 1:100
z = sin(t)
e = cos(t)
n = -sin(t)

wp = subplot(2,4,[1:3]), plot(t,z)
h = zoom;
h.ActionPostCallback = @waveformZoom;
h.Enable = 'on';

wp.XLim
data_range = wp.XLim(1):wp.XLim(2)
data_range = 8:15

plotPM(z, e, n, data_range);

    function waveformZoom(~, eventdata, input_number)
        
        disp(input_number)
        
    end

function plotPM(vert, east, north, data_range)

    en = subplot(2,3,4), plot(east(data_range), north(data_range))


end



end