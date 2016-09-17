%% Personal Finance Analysis - Fiscal Year 2015/2016
% This is a personal financial analysis from Oct 2015 to Sep 2016.

%% Tracking Transactional Data
% Financial transactions are logged using Mint.com. Electronic purchases
% and deposits are automatically logged by Mint, and cash purchases and
% deposits are enterred manually. Each transaction is categorized and
% marked with labels, as necessary.

%%
% Data are exported from Mint to a csv file where it is loaded into Matlab
% for more detailed analysis. The Mint csv file is first filtered for
% transactions that occur within the fiscal year. The file is then filtered
% to remove _Reimbursable_ transactions and _Transfers_.

Tall = importTransactions('/Users/jaywellik/GoogleDrive/transactions.csv'); % import data
T = filterTransactions(Tall); % narrow by date, remove reimbursable transactions, remove transfers, etc.

%%% Handling +/- Cash Flow
% Unfortunately, when Mint exports data to a csv file, all values are
% reported as positive regardless of whether or not they are an expense or
% an income. Therefore it is necessary to change expenses to negative
% numbers when the csv file is imported.
%
%%% Example: Tax Refunds
% An example of a time when this might get confusing is Tax Refunds. Tax is
% payed over the course of months in small negative amounts, and then a
% large positive tax refund is then deposited. Thus, it is not possible to
% simply split the original tax payments into the final expense and a
% re-imbursable part. The easiest thing to do would be to simply have "Tax
% Refund" grouped as an expense but let it have a positive value.

%%
% Some line items in the Mint csv file do no fully describe the true
% transaction. For example, Mint records all paychecks from the USGS as a
% single line item categorized as _Paycheck_. The amount for this single
% line item is the net pay earned for that pay period. In reality, a
% paycheck includes many line items that specify gross salary and
% deductions such as taxes or money set aside for retirment plans. It would
% be onerous to modify each of these line items manually in Mint, so
% instead, each _Paycheck_ line item is processed in Matlab so that it is
% split into many line items that represent the true contents of the
% paycheck.
%
% This would also be useful for rent payments because each rent transaction
% actually represents rent and utilities. Currently, those modifications
% are not made at all.

T = modifySalaryLineItems2(T);

%%
% This is a list of all cagetegories used by Mint for this analysis.

M.MintCategoryNames = unique(T{:,'Category'});
% M.MintCategoryExpInc = double(size(M.MintCategoryNames)); % initialize variable to store whether or not category is an expense or income

%% Creating a Budget
% Further analysis in Matlab includes defining different budget groups.
% Each budget group is populated by a list of Mint categories.
%
% Budget categories for this fiscal year include:
%
% * INCOME (+)
% * EXPENSES (-)
% * SAVINGS (-) - paycheck deductions that contribute directly to savings
% plans.
% * BENEFITS (+) - employer matched contributions from each paycheck.
%

% Specific Budget
% FY17defineBSpecific; % creates var -> BSpeciifc
defineBSpecific;

% Basic Budget
% FY17defineBBasic; % creates var -> BBasic
defineBBasic;

    % 50-30-20% Budget
defineB503020; % creates var -> B503020
% FY17defineB503020;

%%% Choose Budget and Assign Groups

B = B503020;
pie(B);
T = assignBudgetGroup1(T, B);
%{
This is the script where I could handle +/- values. Each group could be
listed as an Income, Expense, Savings, or Benefit. Then, this
assignBudgetGroup would assign + or - accordingly. Afterwards, anything
tagged (or some way identified as a refund or reimbursement) could be given
an absolute value so that it remains positive).
%}

%% MONTHLY REPORTS
% % Plots of spending by category by month.
% 
% figure;
% plotMonthlySpending(T, B, {'Salary'; 'Necessities'; 'Personal'})
% 
%% FINAL REPORTS
% The final reports for the end of the year all revolve around specific
% questions that I ask myself about my finances. There are really three
% main questions:
%
% * How much money am I making?
% * How much money am I spending?
% * How much money is left over as savings?
%
% There is more than one way to tally everything up to get the answers to
% these questions.
%
%%% How much money am I making?
% For example, how much money I make could include the following inputs:
%
% * SALARY
% * PER DIEM
% * BENEFITS
% * INTEREST EARNED
% * OTHER INCOME (Such as gifts)
%
%%% How money am I spending?
% This question is a little more straight forward. There are endless ways
% to break down spending into budget groups, but that is the job of the
% budget, so we wont discuss it here.
%
%%% How much money do I have left over as savings?
% Conceptually, the answer is simple because it's just Income - Expenses,
% but because there are a lot of way to tally Income and Expenses (mainly
% Income), it's worth thinking of simple ways to quickly tally Savings on
% its own. Here are some ideas:
%
% * SAVINGS = SALARY  - EXPENSES (+ BENEFITS) 
% (+ PER DIEM) (+ INTEREST EARNED) (+ OTHER INCOME)
%
% Note, the Savings that are deducted from the Paycheck don't need to be
% included in this equation because they are not counted as an expense.
%
% The total amount of savings accumulated during a given year can be
% calculated as:
%
% * *TOTAL_SAVINGS = INCOME + BENEFITS - EXPENSES*
%
% Because *SAVINGS* is not counted as an expense given the budget groups
% defined above, it is not necessary to add *SAVINGS* in the above
% equation.
%
% TOTAL INCOME
%
% * *TOTAL_INCOME = SALARY + BENEFITS*
%

budgetReport(B, T);


%% SPECIALY REPORTS
% 
% * Amount of Per Diem vs. Amount of Money Spent on Business Travel
% * Re-run analysis so that neither Per Diem or Business Travel expeneses
% are included (assuming Per Diem > Business Travel).
%

%% Appendix

% listTransactions(T)
% M.MintCategoryNames

%% Example Usages
%
% plotMonthlySpending(T, B, {'Groceries'; 'Restaurants'; 'Coffee Shops'})
% T(strcmp(T.Category,'Groceries') & T.Date >= '05/01/2016' & T.Date <= '05/31/2016', :)
% listTransactions(T(strcmp(T.Category,'Groceries') & T.Date >= '05/01/2016' & T.Date <= '05/31/2016', :))
% sum(T{strcmp(T.Category,'Groceries') & T.Date >= '05/01/2016' & T.Date <= '05/31/2016', 'Amount'})




