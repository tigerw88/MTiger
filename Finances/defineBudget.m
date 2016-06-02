function [B] = defineBudget()
% DEFINEBUDGET Define the budget category names, amounts, and corresponding
% Mint categories
%
% OUTPUT:
% + B - Budget
%


%%

mstart = datetime('2015-09-01');
BudgetDates = mstart + calmonths(1:12);


%%

n = 0;

    %
n = n+1;
Group{n} = 'Dining';
BudgetAmount(n) = -400*12;
GroupCategories{n} = {'Restaurants', 'Coffee Shops', 'Alcohol & Bars'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Living';
BudgetAmount(n) = -250*12;
GroupCategories{n} = {'Groceries', 'Home Supplies', 'Pharmacy'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Driving';
BudgetAmount(n) = -70*12;
GroupCategories{n} = {'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Pers. Discretionary';
BudgetAmount(n) = -250*12;
GroupCategories{n} = {...
    'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation'};
% What to do about 'Vacation'?
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Gym';
BudgetAmount(n) = -100*12;
GroupCategories{n} = {'Gym'};
% Most of 'Sports' transactions should be changed to 'Gym'
GroupExpInc(n) = -1;




%% 


    %
n = n+1;
Group{n} = 'Housing';
BudgetAmount(n) = -(1250*9 + 1000*3);
GroupCategories{n} = {'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Shopping';
BudgetAmount(n) = -3000;
GroupCategories{n} = {'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service &amp; Parts', 'Home', 'Furnishings'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Auto';
BudgetAmount(n) = -1500;
GroupCategories{n} = {'Auto Insurance', 'Service & Parts'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Travel';
BudgetAmount(n) = -250*12;
GroupCategories{n} = {'Air Travel', 'Rental Car & Taxi', 'Travel'};
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Taxes';
BudgetAmount(n) = -60000*0.2;
GroupCategories{n} = {'State Tax', 'Federal Tax', 'Gov Fine', 'Tax'};
GroupExpInc(n) = -1;


%% 


    %
n = n+1;
Group{n} = 'Salary';
BudgetAmount(n) = 60000;
GroupCategories{n} = {'Paycheck', 'Salary'};
GroupExpInc(n) = 1;

    %
n = n+1;
Group{n} = 'Other Income';
BudgetAmount(n) = 60000;
GroupCategories{n} = {'Income', 'Interest Income', 'Gift Received'};
GroupExpInc(n) = 1;

    %
n = n+1;
Group{n} = 'Per Diem';
BudgetAmount(n) = 60000;
GroupCategories{n} = {'Per Diem'};
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
