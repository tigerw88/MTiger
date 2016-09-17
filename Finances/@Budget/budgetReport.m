function val = budgetReport( budget, trans )
%BUDGETREPORT Analyzes how money was spent compared to the budget

%%

val = zeros(size(budget.groups));

for n = 1:numel(budget.groups)

    val(n) = sum(trans{strcmp(trans.Group, budget.groups(n).name) ... % matching group name
        & trans.Date >= budget.budget_dates(1) ... % >= start date of budget
        & trans.Date < budget.budget_dates(end) + calmonths(1), ... % < stop month of budget + 1 month
        'Amount'});

end

obj = budget;

disp(' ')
fprintf('  %s\n', upper(obj.name))
fprintf('    %s - %s (%i months)\n', ...
    datestr(obj.start, 'yyyy-mmm'), ...
    datestr(obj.budget_dates(end), 'yyyy-mmm'), ...
    obj.nmonths);
disp(' ')
fprintf('    with groups:\n')
for n = 1:numel(obj.groups)
    fprintf(' %25s : $%10.2f   $%10.2f\n', ...
        obj.groups(n).name, ...
        obj.groups(n).amount, ...
        val(n));
end
fprintf(' %25s   %11s\n', ' ', '----------');
fprintf(' %25s   $%10.2f\n', 'EXP', 0); % total of all negative amounts
fprintf(' %25s   $%10.2f\n', 'INC', 0); % total of all positive amounts
fprintf(' %25s   %11s\n', ' ', '----------');
fprintf(' %25s   $%10.2f\n', ' ', obj.balance);
fprintf(' %25s -->   (%3.1f%%)\n', 'Savings', ...
    obj.balance_as_perc_income * 100);
disp(' ')


end