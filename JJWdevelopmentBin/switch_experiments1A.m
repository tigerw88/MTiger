function switch_experiments1A( window_type )
%% Experimenting with switch

% window_type = 'all';
% window_type = [datenum(2002,01,01) datenum(2013,1,1)];

%% Parse through input
% The window type can be a character expression ('all' | 'individual' |
% 'past') or it can be hard-coded as dates

if ischar(window_type)
    
    switchThroughCharacterOptions( window_type );
    
else
    
    switchThroughNumericOptions( window_type );

end

%% Sub-Routines
%% Character Input

    function switchThroughCharacterOptions( input_char )
        
        % if the window_type is a string - step through the possible options
        switch input_char
            
            case 'all'
                
                display('You chose to run ''all''.')
                %         [BE, P, background_N, background_T] = calculateForAllWindows( eventtimes, windows, ndays, it, be_thresPer );
                
            case 'individual'
                
                display('You chose to run ''individual''.')
                
                %         error('Calculate Empirical Beta for Each Window: This feature is not yet available :-(')
                %         [BE, P] = calculateForIndWindows();
                
                
            case 'past'
                
                display('You chose to run ''past''.')
                
                %         error('Calculate Empirical Beta for Past Data: This feature is not yet available :-(')
                %         [BE, P] = calculateForPastWindows();
                
            otherwise
                
                error('The function did not understand how you want to define the time period for background.')
                
        end

    end

%% Numeric Input

    function switchThroughNumericOptions( input_values )
        
        % do whatever is necessary if the start and stop of background
        % times are inputted
        
    end

end % :-)