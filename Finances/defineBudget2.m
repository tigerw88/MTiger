function [B] = defineBudget2()
% DEFINEBUDGET Define the budget category names, amounts, and corresponding
% Mint categories
% * This budget is specifically defined to analyze expenses as taxes,
% housing, and other
%
% OUTPUT:
% + B - Budget
%


%%

mstart = datetime('2015-09-01');
BudgetDates = mstart + calmonths(1:12);


%% EXPENSES

n = 0;

    %
n = n+1;
Group{n} = 'Taxes';
BudgetAmount(n) = -60000*0.33;
GroupCategories{n} = {'State Tax', 'Federal Tax', 'Gov Fine', 'Misc. Deduction', 'State Tax Refund', 'Federal Tax Refund'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Housing';
BudgetAmount(n) = -(1250*9 + 1000*3);
GroupCategories{n} = {'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Other';
BudgetAmount(n) = -60000*0.27;
GroupCategories{n} = {'Restaurants', 'Coffee Shops', 'Alcohol & Bars', ...
    'Groceries', 'Home Supplies', 'Pharmacy', ...
    'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail', ...
    'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', 'Mobile Phone', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation', ...
    'Gym', ...
    'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service Parts', 'Home', 'Furnishings', ...
    'Auto Insurance', 'Service & Parts', 'Car Fees', ...
    'Air Travel', 'Rental Car & Taxi', 'Travel'};
GroupExpInc(n) = -1;

%% INCOME

    %
n = n+1;
Group{n} = 'Salary';
BudgetAmount(n) = 60000;
GroupCategories{n} = {'Paycheck', 'Salary'};
GroupExpInc(n) = 1;

    %
n = n+1;
Group{n} = 'Other Income';
BudgetAmount(n) = 1;
GroupCategories{n} = {'Income', 'Interest Income', 'Gift Received'};
GroupExpInc(n) = 1;

    %
n = n+1;
Group{n} = 'Per Diem';
BudgetAmount(n) = 1;
GroupCategories{n} = {'Per Diem'};
GroupExpInc(n) = 1;

    % Savings
n = n+1;
Group{n} = 'Savings';
BudgetAmount(n) = 60000*0.05;
GroupCategories{n} = {'TPS'};
GroupExpInc(n) = 1;
        
%% Transpose

% make sure everything is sized n-by-1
B.BudgetDates = BudgetDates;
B.Group = Group';
B.BudgetAmount = BudgetAmount';
B.GroupCategories = GroupCategories';
B.GroupExpInc = GroupExpInc';

%% 

% What to do about --> 'Furnishigs', 'Business Services', 'Security
% Deposit', 'Cash & ATM', 'Travel', 'Vacation', 'Fees & Charges'
% Corrections --> 'Sports' to 'Gym', 'Eisenhowser Bagel' transaction,
% 'Shopping'
% 'China East' transaction

%%
end
