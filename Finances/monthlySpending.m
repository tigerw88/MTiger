function [ monthly_category_amounts ] = monthlySpending( trans, budget )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%% run

all_category_names = unique(trans{:,'Category'});


for c = 1:numel(all_category_names)
    
    for m = 1:numel(budget.BudgetDates)
    
        this_month = budget.BudgetDates(m);
        T = trans( (trans.Date > this_month & trans.Date < this_month + calmonths(1)) & ...
            strcmp(trans.Category,all_category_names{c}), ...
            :);
        monthly_category_amounts(c, m) = sum(T{:,'Amount'});
    
    end
    
end

end

