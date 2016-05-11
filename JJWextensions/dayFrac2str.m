function str = dayFrac2str( fraction )
% DAYFRAC2STR Returns a numeric fraction of a day into a string for
% labeling purposes.

if (fraction >= 1) % if the fraction is a day or more
    str = [num2str(fraction) ' day']; % return the number of days
    if (fraction > 1); str = [str 's']; end; % add an 's' if it is more than 1 day
    
else % else the bin is a fraction of a day
    h = fraction * 24; % determine the number of hours
    str = [num2str(h) ' hour']; % return the number of hours
    if h > 1, str = [str 's']; end; % add an 's' if it is more than 1 hour
    
end

end