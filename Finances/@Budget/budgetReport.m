function val = budgetReport( budget, trans, varargin )
%BUDGETREPORT Analyzes how money was spent compared to the budget
% Only analyzes transactions up to the current date.
%
% INPUT
% budget
% trans
% varargin - optional input argument - The date on which to conduct the analysis.
%  If this date is after the end of the budget period, the date will be
%  changed to the end of the budget period
%

%% derived variables

if nargin>2, analysis_date = datestr(varargin{1}); else, analysis_date = date; end
analysis_date = min([analysis_date budget.stop]);

trans(trans.Date > datetime(datestr(analysis_date)), :) = [];
perc_passed = (datenum(analysis_date) - datenum(budget.start)) / budget.duration_days; % percent of the budget time that has passed

%%

val = zeros(size(budget.groups));

% val - the total amount of money spent on a certain group summed across
% all budget groups
for n = 1:numel(budget.groups)

    val(n) = sum(trans{strcmp(trans.Group, budget.groups(n).name) ... % matching group name
        & trans.Date >= budget.budget_dates(1) ... % >= start date of budget
        & trans.Date < budget.budget_dates(end) + calmonths(1), ... % < stop month of budget + 1 month
        'Amount'});

end

obj = budget;

disp(' ')
disp('  BUDGET REPORT:')
fprintf('  %s\n', upper(obj.name))
fprintf('    %s - %s (%i months)\n', ...
    datestr(obj.start, 'yyyy-mmm'), ...
    datestr(obj.budget_dates(end), 'yyyy-mmm'), ...
    obj.nmonths);
fprintf('    Present Date: %s (%2.1f%% of Budget Passed)\n', datestr(analysis_date), perc_passed*100);
disp(' ')
fprintf('    with groups:\n')
fprintf(' %25s : %11s   %11s   : %14s   %11s\n', '     ', 'Budgeted', 'To Date', '% of Target', '$ Remaining')
for n = 1:numel(obj.groups)
    
    perc_of_budget_to_date = val(n) / (obj.groups(n).amount*perc_passed) * 100;
    amt_remaining = abs(obj.groups(n).amount - val(n));
    
    fprintf(' %25s : $%10.2f   $%10.2f   : (%11.1f%%)   $%11.2f\n', ...
        obj.groups(n).name, ...
        obj.groups(n).amount, ...
        val(n), ...
        perc_of_budget_to_date, amt_remaining);
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