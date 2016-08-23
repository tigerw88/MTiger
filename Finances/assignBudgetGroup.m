function T2 = assignBudgetGroup(T, B)
% ASSIGNBUDGETGROUP Creates a new column in the table that includes the
% budget group.
%
% INPUT
% + T - Table of transactions
% + B - Budget
%
%

for n = 1:numel(B.Group) % for each category
    
    group_name = B.Group{n}; % get the category name
    exp_or_inc = B.GroupExpInc(n); % determine whether or not it is an expense or income

    for k = 1:numel(B.GroupCategories{n}) % for each category in the given group
    
        category_name = B.GroupCategories{n}{ k}; % get the category name
        idx = (strcmp(T.Category, category_name)); % index of all transactions with this category name
        T{idx, 'Group'} = strrep(T{idx, 'Group'}, 'Ungrouped', group_name); % change group name from 'Ungrouped' to the given group name
        T{idx, 'Amount'} = T{idx, 'Amount'}*exp_or_inc; % change amounts to negative or postive depending on whether or not the group is an expense or an income
        if (strcmp(category_name, 'State Tax Refund') || strcmp(category_name,'Federal Tax Refund')) % make sure tax refunds are positive values
            T{idx, 'Amount'} = abs(T{idx, 'Amount'});
        end
        
    end
        
end

T2 = T;

end