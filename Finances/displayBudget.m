function displayBudget( B )
%DISPLAYBUDGET Displays Budget information
% Uses Matlab's table datatype to display information

B2 = rmfield(B, 'BudgetDates');
display(struct2table(B2))

end

