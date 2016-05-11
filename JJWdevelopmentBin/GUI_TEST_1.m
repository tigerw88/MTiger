function GUI_TEST_1
% GUI_TEST_1 Sets up a user interface to determine power law functions for clean signals.
% This interface allows a user to scroll through pre-selected waveforms
% to determine how to best fit a power law function to the data.


%% GUI Constants


	% start-up location
GUI_LOC.X = 360;
GUI_LOC.Y = 500;
GUI_LOC.W = 600;
GUI_LOC.H = 285;

	% color and line settings
COLOR.waveform = 'b'
COLOR.envelope = 'k'
COLOR.power_law = 'r';
SIZE.power_law = 2;


%% Build the GUI
% This initializes the GUI but hides it from the user because the features have not been set up yet.


f = figure('Visible','off','Position',[GUI_LOC.X,GUI_LOC.W,GUI_LOC.W,GUI_LOC.H]);


%% Add components
% This draws all of the interactors onto the interface. No functionality implemented here.


	% Event type drop-down menu
hevent_type = uicontrol('Style','popupmenu',...
	'String',{'Earthquake Type','High Frequency','Hybrid','Low Frequency'},...
	'Position',[300, 1, 99, 25],...
	'Callback',@event_type_callback);
	
	% Draw Envelope button
hdraw_envelope = uicontrol('Style','pushbutton',...
	'String','Draw Envelope',...
	'Position',[401, 1, 99, 25],...
	'Callback',@draw_envelope_callback);

	% Fit Power Law button
hfit_powerlaw = uicontrol('Style','pushbutton',...
	'String','Fit Power Law',...
	'Position',[501, 1, 99, 25],...
	'Callback',@fit_powerlaw_callback);
	
	% SUBMIT button
hsubmit = uicontrol('Style','pushbutton',...
	'String','SUBMIT',...
	'Position',[601, 1, 99, 25],...
	'BackgroundColor','red',...
	'Callback',@submit_callback);


%% Add data plot
% Adds a splace for data to be plotted. No actual data is plotted.


	% Waveform plot axes
ha = axes('Units','pixels','Position',[300, 50, 400, 185]);


%% Add Event Info
% Adds text on the GUI for user reference.


	% stub data - SCNL
station = 'MMLR'; % stub
channel = 'EHZ'; % stub
network = 'ID'; % stub
location = '--'; % stub

	% stub data - event info
p_arrival = '03/17/1988 04:13:00'; % stub
s_arrival = '03/17/1988 04:13:04'; % stub
coda_stop = '03/17/1988 04:13:20'; % stub
duration_magnitude = 3.4; % stub


	% Add SCNL info at the top of the screen
hSCNLinfo = uicontrol('Style','text',...
	'String',['SCNL: ' station channel network location],...
	'Position',[1, 300, 99, 15]);

	% Add event & pick info stored in database
hevent_info = uicontrol('Style','text',...
	'String',['Event Info:'],...
	'Position',[315, 240, 60, 15]);
hParrival = uicontrol('Style','text',...
	'String',['P: ' datestr(p_arrival)],...
	'Position',[315, 220, 60, 15]);
hSarrival = uicontrol('Style','text',...
	'String',['S: ' datestr(s_arrival)],...
	'Position',[315, 200, 60, 15]);
hcoda_stop = uicontrol('Style','text',...
	'String',['Code Stop: ' datestr(coda_stop)],...
	'Position',[315, 180, 60, 15]);
hduration_magnitude = uicontrol('Style','text',...
	'String',['Md (database): ' datestr(duration_magnitude)],...
	'Position',[315, 160, 60, 15]);



%% Add Power Law Fit Results Info
% Prints the results of the curve fitting analysis to the screen. No actual computing done here.


	% Add info about results of the analysis
hresults_info = uicontrol('Style','text',...
	'String',['Power Law Results:'],...
	'Position',[315, 120, 60, 15]);
hfunction_definition = uicontrol('Style','text',...
	'String',['f(x): '],...
	'Position',[315, 240, 60, 15]);

		
%% Program the UI behavior
% This is where all of the computing is done.


	% Event type callback
function event_type_callback(source,eventdata)

		% Determine the selected event type	
	str = source.String;
	val = source.Value;
	
		% Set the event type to the selected type
		% 'event_type' NEEDS TO LINK TO THE DATABASE
	switch str{val};
	case 'Earthquake Type'
		event_type = '';
	case 'High Frequency' % User selects High Frequency Earthquake
		event_type = 'HF';
	case 'Hybrid' % User selects Hybrid Earthquake
		event_type = 'HY';
	case 'Low Frequency' % User selects Low Frequency Earthquake
		event_type = 'LF';
	end

end


	% Draw Envelope callback
function draw_envelope_callback(source,eventdata)



end


	% Fit Power Law callback
function fit_powerlaw_callback(source,eventdata)



end


	% Submit button callback
function submit_callback(source,eventdata)



end


%% Turn on the GUI


	% Change units to 'normalized' so that components resize automatically
f.Units = 'normalized';
ha.Units = 'normalized';

hevent_type.Units = 'normalized';
hgenerate_envelope.Units = 'normalized';
hfit_powerlaw.Units = 'normalized';
hsubmit.Units = 'normalized';
% ALL OTHER HANDLES (INCLUDING TEXT) NEED TO BE NORMALIZED HERE! ANNOYING!
% Can I just make all of the handles part of a structure; e.g., h.submit - so that I can
% normalize everything with one line of code: >> h[1,:].Units = 'Normalized'; ? Will that work?

	% Generate the data to plot



	% Create a plot in the axes
	
	
	
	% Assign a name to appear in the window title
f.Name = 'GUI TEST 1';

	% Move the window the nearest location that still allows it to display on the full screen
movegui(f,'onscreen');

	% Make the UI visible
f.Visible = 'on';


end
%% END FUN :-) jwellik <at> usgs.gov | johnwellikii <at> gmail.com