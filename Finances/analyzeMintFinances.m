%% analyzeMintFinances

    % Import Data
Tall = importTransactions('/Users/jaywellik/GoogleDrive/transactions.csv'); % import data

MintCategoryNames = unique(Tall{:,'Category'});
MintCategoryExpInc = double(size(MintCategoryNames)); % initialize variable to store whether or not category is an expense or income

B = defineBudget(); % create a budget

% approximateTaxFromPaycheck; % find all paycheck transactions and make sure it properly reflects salary, taxes, etc.

T = filterTransactions(Tall); % narrow by date, remove reimbursable transactions, remove transfers, etc.

T = assignBudgetCat(T, B); % assign budget categories

% displaySummary;
displayTable(T)
% displayTable(T(strcmp(T.BudgetCat,'Dining'), :))

budgetReport(T, B)
