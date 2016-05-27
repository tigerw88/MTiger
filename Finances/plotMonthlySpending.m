function [ output_args ] = plotMonthlySpending( trans, budget, category )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

spending = monthlySpending( trans(strcmp(trans.Category, category), :), budget);
plot(budget.BudgetDates, spending, 'k-');

end

