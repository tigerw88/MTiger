function output = cell2datenum( input )
% CELL2DATENUM Given a cell array of datestrings, change all values to
% datenums. You'd think Matlab can do this easier, but I haven't found a
% way to do it in one line.

if size(input,1) == 1 % if there is a singular input; by using SIZE, you catch 'char' types and 'cell' types
    
    output = datenum(input);
    
else % if it is a matrix or vector of datestr
    
    output = nan(size(input));
    for j = 1:size(input,2) % for every column
        
        output(:,j) = datenum(input(:,j));
        
    end
    
end