function PARTICLE_MOTION_1
% PARTICLE_MOTION_1 Sets up a GUI to analyze particle motion for waveforms exported from
% Swarm. This applet is designed to be used with Swarm.

%% GUI CONSTANTS

	% start-up locations
GUI_LOC.X = 360;
GUI_LOC.Y = 500;
GUI_LOC.W = 650;
GUI_LOC.H = 600;

	% plot locations for waveform object
% WAVEFORM_LOC.X = 0;
% WAVEFORM_LOC.Y = 400;
% WAVEFORM_LOC.W = 300;
% WAVEFORM_LOC.H = 200;

	% color settings
COLOR.Waveform = 'b';
COLOR.ParticleMotionTrace = 'k';
COLOR.Labels = 'k';


%% Build the GUI panels
% This initializes the GUI but hides it from the user because the features have not been set up yet.

	% initialize the figure window
f = figure('Visible','off','Position',[GUI_LOC.X,GUI_LOC.W,GUI_LOC.W,GUI_LOC.H]);

	% initialize the panels
% wp = uipanel('Title','Waveform Panel',...
% 	'Units','pixels',...
%     'Position',[0, 225, 500, 375]);

	% initialize the panels
% a = axes('Parent',wp,'Position',[0, 225, 500, 375]);
plot(1:100,sin(1:100));
	
nep = uipanel('Title','North-East Particle Motion',...
	'Units','pixels',...
    'Position',[0, 0, 200, 200]);

zep = uipanel('Title','Vertical-East Particle Motion',...
	'Units','pixels',...
    'Position',[225, 0, 200, 200]);

znp = uipanel('Title','Vertical-North Particle Motion',...
	'Units','pixels',...
    'Position',[450, 0, 200, 200]);
	
	% initialize the top and bottom tool bars
% ttbp = uipanel('Title','Top Tool Bar',...
% 	'Units','pixels',...
%     'Position',[0, 350, 800, 50]); % Top Tool Bar Panel
% btbp = uipanel('Title','Bottom Tool Bar',...
% 	'Units','pixels',...
%     'Position',[0, 0, 800, 50]); % Bottom Tool Bar Panel

%% Build the plots

plot(1:1000,sin(1:1000));




%% Add components
% This draws all of the interactors onto the interface. No functionality implemented here.

% To add one of these components to a panel, add this text to the uicontrol statement:
% ... 'Parent',nep...
% It looks like it should be the very first item in the uicontrol input parameters.
% Then remember that the default position units are 'normalized' if something is placed in a panel.


	% Draw Export button
hdraw_export = uicontrol('Style','pushbutton',...
	'String','EXPORT',...
	'Position',[525, 225, 100, 25],...
    'BackgroundColor','red',...
	'Callback',@export_callback);

	% Display Rotate text
hrotate_text = uicontrol('Style','text',...
	'String',['Rotate (deg): '],...
	'Position',[500, 580, 100, 15]);
	
	% Enter Rotation Value
hrotate_value = uicontrol('Style','edit',...
    'Position',[525, 560, 100, 15],...
    'Callback',@get_rotate_value_callback);
	




	% Event type drop-down menu
% hevent_type = uicontrol('Style','popupmenu',...
% 	'String',{'Earthquake Type','High Frequency','Hybrid','Low Frequency'},...
% 	'Position',[300, 1, 99, 25],...
% 	'Callback',@event_type_callback);
	
	% Draw Envelope button
% hdraw_envelope = uicontrol('Style','pushbutton',...
% 	'String','Draw Envelope',...
% 	'Position',[401, 1, 99, 25],...
% 	'Callback',@draw_envelope_callback);

	% Fit Power Law button
% hfit_powerlaw = uicontrol('Style','pushbutton',...
% 	'String','Fit Power Law',...
% 	'Position',[501, 1, 99, 25],...
% 	'Callback',@fit_powerlaw_callback);
	
	% SUBMIT button
% hsubmit = uicontrol('Style','pushbutton',...
% 	'String','SUBMIT',...
% 	'Position',[601, 1, 99, 25],...
% 	'BackgroundColor','red',...
% 	'Callback',@submit_callback);

%% Program the UI behavior
% This is where all of the computing is done.


	% EXPORT callback
function export_callback(source,eventdata)

		% not sure if this is necessary here	
	str = source.String;
	val = source.Value;

        % stub action
    disp(['EXPORT button pressed']);
    disp('  -To be programmed: Write text files.');
    disp(' ');
	
end


    % Rotate callback
    % Rotates waveforms by n degrees in a ccw direction from the x-axis.
function get_rotate_value_callback(source,eventdata)
    
        % retrieve export value from user
    rotate_value = str2double(source.String);
    
        % stub action
    disp(['The waveforms will be rotated by ' num2str(rotate_value) ' degrees CCW from the x-axis.']);
    disp('  -To be programmed: Rotate waveforms.');
    disp('  -To be programmed: Add note in waveform panel about current rotation.');
    disp('  -To be programmed: Change waveform channels to radial and tangential.');
    disp('  -To be programmed: case == 0; clear all rotations and reset channel to N/E.');
    disp('  -To be programmed: Do not accept value over 359 or below -359; or handle them properly');
    disp(' ');
    
end



%% Turn on the GUI

f.Visible = 'on';


end