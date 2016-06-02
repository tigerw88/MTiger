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
% T = splitTransaction(T(strcmp(T.Category, 'Paycheck'), :), {'Salary', 'State Tax', 'Federal Tax'}, [1.5 0.75 0.75], 'amounts');
% T = splitTransaction(T(strcmp(T.Category, 'Paycheck'), :), {'Salary', 'State Tax', 'Federal Tax'}, [2000 500 500], 'dollars');
T = assignBudgetGroup(T, B); % assign budget categories


listTransactions(T)

generateReport(T, B);
