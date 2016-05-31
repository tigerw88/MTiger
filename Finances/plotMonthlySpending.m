function [ output_args ] = plotMonthlySpending( trans, budget, category )
%PLOTMONTHLYSPENDING Make a time serie plot of monthly spending for a list
%of transactions given a budget
%   Detailed explanation goes here
%
% INPUT
% + trans - a table of transactions
% + budget - a budget
% + category - the category that you wish to plot
%

%%

spending = monthlySpending( trans(strcmp(trans.Category, category), :), budget);
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

