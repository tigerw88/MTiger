%{
Prints message to the window about each background window that contains at
least one bad data day and highlights that window and those bad data days
from the previous plot in blue.
%}


sprintf('Window %s (from %s to %s): There are %s bad data days in this window.',...
    num2str(n),...
    datestr(windows(n,1)),...
    datestr(windows(n,2)), ...
    num2str(length(series_tmp)))


plot([windows(n,1) windows(n,1)],[0 1],'b:'), hold on
plot([windows(n,2) windows(n,2)],[0 1],'b--')
plot(series_tmp, 0.5, 'sb')