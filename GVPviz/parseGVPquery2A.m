%% parseGVPquery
% Sets the colors for VEI amongst other things

%% Parse date info into datenum and datetime var types

StartDatenum = datenum(StartDateYear, StartDateMonth,StartDateDay);
EndDatenum = datenum(EndDateYear, EndDateMonth, EndDateDay);
StartDatetime = datetime(StartDateYear, StartDateMonth,StartDateDay);
EndDatetime = datetime(EndDateYear, EndDateMonth, EndDateDay);


%% associate color with VEI
% There's gotta be a better way to do this.

for n = 1:length(ExplosivityIndexMax)

    val = ExplosivityIndexMax(n);
    
    if isnan(val)
        
        VEI_color{n} = [0.5 0.5 0.5];
        
    elseif val==0
        
        VEI_color{n} = [153/255 204/255 255/255]; % light blue
        
    elseif val==1
        
        VEI_color{n} = [0 0 204/255]; % dark blue
        
    elseif val==2
        
        VEI_color{n} = [0 153/255 0]; % green
        
    elseif val==3
        
        VEI_color{n} = [200/255 200/255 0]; % yellow
        
    elseif val==4
        
        VEI_color{n} = [255/255 128/255 0]; % orange
        
    elseif val==5
        
        VEI_color{n} = [204/255 0 0]; % red
        
    elseif val>=6
        
        VEI_color{n} = [102/255 0 102/255]; % black
        
    end
    
end


%%

all_volcanoes = unique(VolcanoName);

for n = 1:length(all_volcanoes)
    
    e_idx = strcmp(VolcanoName, all_volcanoes{n}); % indices for each eruption at a particular volcano
    v_idx = find(e_idx==1, 1, 'first'); % index of first occurence for each volcano
    
        % put volcano information into a structure
    VOLCANO(n).name = VolcanoName{v_idx};
    VOLCANO(n).vnum = VolcanoNumber(v_idx);
    VOLCANO(n).lon = LongitudeDecimal(v_idx);
    VOLCANO(n).lat = LatitudeDecimal(v_idx);
    VOLCANO(n).elev = Elevation(v_idx);
    VOLCANO(n).morphology = { MorphType1{v_idx}; MorphType2{v_idx}; MorphType3{v_idx}; ...
                            MorphType4{v_idx}; MorphType5{v_idx}; MorphType6{v_idx} };
    VOLCANO(n).tectonic_setting = TectonicSetting(v_idx);
    VOLCANO(n).rock_type = RockType{v_idx};
    VOLCANO(n).country = Country{v_idx};
    VOLCANO(n).activity_type = ActivityType{v_idx};
    VOLCANO(n).remarks = Remarks{v_idx};
    
        % put eruption chronology into structure
    VOLCANO(n).ERUPTIONS.StartDatenum = StartDatenum(e_idx);
    VOLCANO(n).ERUPTIONS.StartDatetime = StartDatetime(e_idx);
    
    VOLCANO(n).ERUPTIONS.EndDatenum = EndDatenum(e_idx);
    VOLCANO(n).ERUPTIONS.EndDatetime = EndDatetime(e_idx);
    
    VOLCANO(n).ERUPTIONS.VEI_max = ExplosivityIndexMax(e_idx);
    VOLCANO(n).ERUPTIONS.vei_mod = ExplosivityIndexModifier(e_idx);
    VOLCANO(n).ERUPTIONS.VEI_color = VEI_color(e_idx);
    
    VOLCANO(n).ERUPTIONS.ActivityID = Activity_ID(e_idx);
    
end




