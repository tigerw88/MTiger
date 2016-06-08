function [ monthly_category_amounts, monthly_group_amounts ] = monthlySpending( trans, budget )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%% run

all_category_names = unique(trans{:,'Category'});
all_group_names = unique(trans{:,'Group'});
monthly_category_amounts = zeros(size(all_category_names));
monthly_group_amounts = zeros(numel(budget.Group), numel(budget.BudgetDates));

%% categories

for c = 1:numel(all_category_names)
    
    for m = 1:numel(budget.BudgetDates)
    
        this_month = budget.BudgetDates(m); %
        this_cat = all_category_names{c}; % 'str' name of category for this iteration
        T = trans( (trans.Date > this_month & trans.Date < this_month + calmonths(1)) & ...
            strcmp(trans.Category, this_cat), ...
            :);
        monthly_category_amounts(c, m) = sum(T{:,'Amount'});
        
    end
    
end


%% groups

for c = 1:numel(all_group_names)
    
    for m = 1:numel(budget.BudgetDates)
    
        this_month = budget.BudgetDates(m); %
        this_group = all_category_names{c}; % 'str' name of category for this iteration
        T = trans( (trans.Date > this_month & trans.Date < this_month + calmonths(1)) & ...
            strcmp(trans.Group, this_group), ...
            :);
        monthly_group_amounts(c, m) = sum(T{:,'Amount'});
        
    end
    
end






end

