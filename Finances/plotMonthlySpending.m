function plotMonthlySpending( trans, budget, type, group_cat )
%PLOTMONTHLYSPENDING Make a time serie plot of monthly spending for a list
%of transactions given a budget
%   Detailed explanation goes here
%
% INPUT
% + trans - a table of transactions
% + budget - a budget
% + type - display a group or a category
% + group_cat - the group or category that you wish to plot
%

%% get spending amounts

switch type
    
    case 'group'
        
        spending = monthlySpending( trans(strcmp(trans.Group, group_cat), :), budget);
        
        
    case 'category'
        
        spending = monthlySpending( trans(strcmp(trans.Category, group_cat), :), budget);
        
    otherwise
        
end

%% plot

bar(datenum(budget.BudgetDates), spending, 'k');
datetick('x'); % has no affect if datetime axis is replaced below

    % use datetime features for x axis
% ax = gca;
% hold on
% plot(ax, budget.BudgetDates, nan(size(budget.BudgetDates)));

    % set plot labels
xlabel('Month')
ylabel('Dollars ($)')
title(sprintf('Monthly Spending/Income: %s', category))

end

