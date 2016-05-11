function ypositions = smartYTextPosition( dataset_length, max_height, increment)
% SMARTYTEXTPOS A slightly smarter way to space labels vertically on a plot

% If you had a maximum y value of 21 and 12 labels to fit vertically at an
% increment of 2, the result of this function would be y labels at
% [1 3 5 7 9 11 13 15 17 19 2 4].

counter = 1;
ypositions = nan(1,dataset_length);

for i = 1:dataset_length
    
    n = counter;
    
    f = n/dataset_length;
    ypositions(n) = max_height * f;
    
    counter = counter + increment;
    
    if counter >= dataset_length;
        if mod(counter,2), counter = 2; else counter = 1; end;
    end
    
end

end