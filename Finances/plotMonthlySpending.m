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
    if sum(strcmp(group_cat{n}, trans.Category))
        
        type = 'Category';
        spending(:, n) = monthlySpending( trans(strcmp(trans.Category, group_cat{n}), :), budget)';
           
        % elseif the string exists as a group name
    elseif sum(strcmp(group_cat{n}, trans.Group))
        
        type = 'Group';
        tmp = monthlySpending( trans(strcmp(trans.Group, group_cat{n}), :), budget);
        if size(tmp,1)==1,
            spending(:,n) = tmp;
        else
            spending(:, n) = sum(tmp);
        end
        
    else
        
        error(['The string ''' group_cat ''' is neither a category nor a group in your transaction list.'])
        
    end
    
    %% plot
    

    
end

bar(datenum(budget.budget_dates), abs(spending), varargin{:});
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

