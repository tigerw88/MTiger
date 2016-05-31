function [ monthly_category_amounts, budget_category_amounts ] = monthlySpending( trans, budget, map )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%% run

all_category_names = unique(trans{:,'Category'});
monthly_category_amounts = zeros(size(all_category_names));
budget_category_amounts = zeros(numel(budget.BudgetCategory), numel(budget.BudgetDates));


for c = 1:numel(all_category_names)
    
    for m = 1:numel(budget.BudgetDates)
    
        this_month = budget.BudgetDates(m); %
        this_cat = all_category_names{c}; % 'str' name of category for this iteration
        T = trans( (trans.Date > this_month & trans.Date < this_month + calmonths(1)) & ...
            strcmp(trans.Category,all_category_names{c}), ...
            :);
        monthly_category_amounts(c, m) = sum(T{:,'Amount'});
        
    end
    
%     idx = find(ismember(map.MintCategoryNames, this_cat)); % find index of this category in map
%     this_budget_cat = map.MintCategoryBudget{idx};
%     idx = find(ismember(budget.BudgetCategory, this_budget_cat));
%     budget_category_amounts(idx, :) = budget_category_amounts(idx, :) + monthly_category_amounts(c, :);
    
end







end

