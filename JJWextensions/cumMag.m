function [ cum_mag, cum_moment ] = cumMag( magnitude )
% CUMMAG A simple function that outputs cumulative Magnitude and Moment
% from a time series.
%   Calculates cumulative magnitude and cumulative moment from a time
%   series of earthquake magnitudes. NaN values are ignored.
% see also MAGNITUDE2MOMENT

moment = magnitude2moment(magnitude); % convert each magnitude to a moment
cum_moment = cumsum(moment(~isnan(moment))); % calculate cumulative moment (only use non-NaN values)
cum_mag = magnitude2moment(cum_moment,'reverse'); % convert cumulative moment back to cumulative magnitude

end

