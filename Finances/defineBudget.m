function [B] = defineBudget()
% DEFINEBUDGET Define the budget category names, amounts, and corresponding
% Mint categories





%%

mstart = datetime('2015-09-01');
BudgetDates = mstart + calmonths(1:12);


%%

n = 0;

    %
n = n+1;
BudgetCategory{n} = 'Dining';
BudgetCategoryBudget(n) = -400*12;
BudgetCategoryCategories{n} = {'Restaurants', 'Coffee Shops', 'Alcohol & Bars'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Living';
BudgetCategoryBudget(n) = -250*12;
BudgetCategoryCategories{n} = {'Groceries', 'Home Supplies', 'Pharmacy'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Driving';
BudgetCategoryBudget(n) = -70*12;
BudgetCategoryCategories{n} = {'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Pers. Discretionary';
BudgetCategoryBudget(n) = -250*12;
BudgetCategoryCategories{n} = {...
    'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation'};
% What to do about 'Vacation'?
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Gym';
BudgetCategoryBudget(n) = -100*12;
BudgetCategoryCategories{n} = {'Gym'};
% Most of 'Sports' transactions should be changed to 'Gym'
BudgetCategoryExpInc(n) = -1;




%% 


    %
n = n+1;
BudgetCategory{n} = 'Housing';
BudgetCategoryBudget(n) = -(1250*9 + 1000*3);
BudgetCategoryCategories{n} = {'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Shopping';
BudgetCategoryBudget(n) = -3000;
BudgetCategoryCategories{n} = {'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service &amp; Parts', 'Home', 'Furnishings'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Auto';
BudgetCategoryBudget(n) = -1500;
BudgetCategoryCategories{n} = {'Auto Insurance', 'Service & Parts'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Travel';
BudgetCategoryBudget(n) = -250*12;
BudgetCategoryCategories{n} = {'Air Travel', 'Rental Car & Taxi', 'Travel'};
BudgetCategoryExpInc(n) = -1;

    %
n = n+1;
BudgetCategory{n} = 'Taxes';
BudgetCategoryBudget(n) = -60000*0.2;
BudgetCategoryCategories{n} = {'State Tax', 'Federal Tax', 'Gov Fine'};
BudgetCategoryExpInc(n) = -1;


%% 


    %
n = n+1;
BudgetCategory{n} = 'Salary';
BudgetCategoryBudget(n) = 60000;
BudgetCategoryCategories{n} = {'Paycheck'};
BudgetCategoryExpInc(n) = 1;

    %
n = n+1;
BudgetCategory{n} = 'Other Income';
BudgetCategoryBudget(n) = 60000;
BudgetCategoryCategories{n} = {'Income', 'Interest Income', 'Gift Received'};
BudgetCategoryExpInc(n) = 1;

    %
n = n+1;
BudgetCategory{n} = 'Per Diem';
BudgetCategoryBudget(n) = 60000;
BudgetCategoryCategories{n} = {'Per Diem'};
BudgetCategoryExpInc(n) = 1;

%% Transpose

% make sure everything is sized n-by-1
B.BudgetDates = BudgetDates;
B.BudgetCategory = BudgetCategory';
B.BudgetCategoryBudget = BudgetCategoryBudget';
B.BudgetCategoryCategories = BudgetCategoryCategories';
B.BudgetCategoryExpInc = BudgetCategoryExpInc';

%% 

% What to do about --> 'Furnishigs', 'Business Services', 'Security
% Deposit', 'Cash & ATM', 'Travel', 'Vacation', 'Fees & Charges'
% Corrections --> 'Sports' to 'Gym', 'Eisenhowser Bagel' transaction,
% 'Shopping'
% 'China East' transaction

%%
end
