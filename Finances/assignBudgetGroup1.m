function T2 = assignBudgetGroup1(T, B)
% ASSIGNBUDGETGROUP Creates a new column in the table that includes the
% budget group.
%
% INPUT
% + T - Table of transactions
% + B - Budget
%
%

%%

EXPENSE = -1;
INCOME = 1;

for n = 1:numel(B.groups) % for each group
    
    group_name = B.groups(n).name; % get the group name
    if B.groups(n).amount < 0;
        group_type = EXPENSE;
    else
        group_type = INCOME;
    end

    for k = 1:numel(B.groups(n).mint_cat) % for each category in the given group
    
        category_name = B.groups(n).mint_cat{k}; % get the category name
        idx = (strcmp(T.Category, category_name)); % index of all transactions with this category name
        T{idx, 'Group'} = strrep(T{idx, 'Group'}, 'Ungrouped', group_name); % change group name from 'Ungrouped' to the given group name
        
        % change amounts to negative or postive depending on whether or not
        % the group is an expense or an income
        if group_type==INCOME
            T{idx, 'Amount'} = abs(T{idx, 'Amount'}); 
        elseif group_type==EXPENSE
            T{idx, 'Amount'} = -abs(T{idx, 'Amount'});
        end
            
        % Make exectpions to the EXPENSES==negative numbers,
        % INCOME==positive numbers rule
        if (strcmp(category_name, 'State Tax Refund') || ... % make sure tax refunds are positive values
                strcmp(category_name,'Federal Tax Refund')); % make sure tax refunds are positive values
            T{idx, 'Amount'} = abs(T{idx, 'Amount'});
        end
        
    end
        
end

T2 = T;

end