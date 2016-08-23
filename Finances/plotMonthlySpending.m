function spending = plotMonthlySpending( trans, budget, group_cat, varargin )
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

subcategorynames = '';

title_str = sprintf('Monthly Spending/Income for: %s', strjoin(group_cat, ', '));


for n = 1:numel(group_cat)
    
    % if the string exists as a category name
    if sum(strncmp(group_cat{n}, trans.Category, 1))
        
        type = 'Category';
        spending(:, n) = monthlySpending( trans(strcmp(trans.Category, group_cat{n}), :), budget)';
        
        % elseif the string exists as a group name
    elseif sum(strncmp(group_cat, trans.Group, 1))
        
        type = 'Group';
        spending(:, n) = monthlySpending( trans(strcmp(trans.Group, group_cat{n}), :), budget);
        spending(:, n) = sum(spending(:, n)); % for n categories, the initial result of spending is n-by-12; sum(spending) makes this a 1-by-12 vector
        %     subcategorynames = budget.GroupCategories{strncmp(budget.Group,'Living',1)};
        
    else
        
        error(['The string ''' group_cat ''' is neither a category nor a group in your transaction list.'])
        
    end
    
    %% plot
    

    
end

bar(datenum(budget.BudgetDates), abs(spending), varargin{:});
datetick('x'); % has no affect if datetime axis is replaced below

% use datetime features for x axis
% ax = gca;
% hold on
% plot(ax, budget.BudgetDates, nan(size(budget.BudgetDates)));

% set plot labels
xlabel('Month')
ylabel('Dollars ($)')
title(title_str)
legend(group_cat)



end

