function T2 = assignBudgetGroup(T, B)
% ASSIGNBUDGETGROUP Creates a new column in the table that includes the
% budget group.
%
% INPUT
% + T - Table of transactions
% + B - Budget
%
%

for n = 1:numel(B.Group)
    
    group_name = B.Group{n};
    
    for k = 1:numel(B.GroupCategories{n})
    
        category_name = B.GroupCategories{n}{ k};
        idx = (strcmp(T.Category, category_name));
        T{idx, 'Group'} = strrep(T{idx, 'Group'}, 'Ungrouped', group_name);
        
    end
        
end

T2 = T;

end