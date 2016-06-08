clear all, close all

%% analyzeMintFinances

    % Import Data
Tall = importTransactions('/Users/jaywellik/GoogleDrive/transactions.csv'); % import data

M.MintCategoryNames = unique(Tall{:,'Category'});
M.MintCategoryExpInc = double(size(M.MintCategoryNames)); % initialize variable to store whether or not category is an expense or income

B = defineBudget(); % create a budget
% M.MintCategoryBudget = category2budgetCategoryMap(MintCategoryNames, B);

T = filterTransactions(Tall); % narrow by date, remove reimbursable transactions, remove transfers, etc.
% T = approximateTaxFromPaycheck(T); % find all paycheck transactions and make sure it properly reflects salary, taxes, etc.
[T, ~] = splitTransaction(T, 'Paycheck', {'Salary', 'State Tax', 'Federal Tax', 'Misc. Deduction', 'TPS'}, [1.6136 0.0980 0.1966 0.2472 0.05], 'percent');
T = assignBudgetGroup(T, B); % assign budget categories


listTransactions(T)

generateReport(T, B);
