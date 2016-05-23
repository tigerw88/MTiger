%% analyzeMintFinances


Tall = importTransactions('/Users/jaywellik/GoogleDrive/transactions.csv');

B = defineBudget();

% approximateTaxFromPaycheck

T = filterTransactions(Tall);

T = summarizeBudgetReport(T, B);

% displaySummary;
displayTable(T)
budgetReport
% displayTable(T(strcmp(T.BudgetCat,'Dining'), :))

% plotTransactions;

