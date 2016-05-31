%% analyzeMintFinances

    % Import Data
Tall = importTransactions('/Users/jaywellik/GoogleDrive/transactions.csv'); % import data

M.MintCategoryNames = unique(Tall{:,'Category'});
M.MintCategoryExpInc = double(size(M.MintCategoryNames)); % initialize variable to store whether or not category is an expense or income

B = defineBudget(); % create a budget
% M.MintCategoryBudget = category2budgetCategoryMap(MintCategoryNames, B);

% approximateTaxFromPaycheck; % find all paycheck transactions and make sure it properly reflects salary, taxes, etc.

T = filterTransactions(Tall); % narrow by date, remove reimbursable transactions, remove transfers, etc.
T = assignBudgetGroup(T, B); % assign budget categories

displayTable(T)

% budgetReport(T, B)
