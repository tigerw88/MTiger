function [B] = defineBudget503020()
% DEFINEBUDGET503020 This budget is used to analyze saving and spending
% based on the 50/30/20 rule where 50% of your paycheck should be used for
% discretionary expenses, 30% should be used for daily and monthly
% necessities, and 20% should be saved.
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
Group{n} = 'Discretionary (50%)';
BudgetAmount(n) = -60000*0.5;
GroupCategories{n} = {...
    'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', 'Mobile Phone', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation', ...
    'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail', 'Service & Parts', ...
    'Groceries', 'Home Supplies', 'Pharmacy', ...
    'Restaurants', 'Coffee Shops', 'Alcohol & Bars', ...
    'Gym', ...
    'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service Parts', 'Home', 'Furnishings', ...
    'Air Travel', 'Rental Car & Taxi', 'Travel', ...
    };
GroupExpInc(n) = -1;

    %
n = n+1;
Group{n} = 'Necessities (30%)';
BudgetAmount(n) = -60000*0.3;
GroupCategories{n} = {  'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water', ...
                        'Auto Insurance', 'Car Fees', ...
                        'State Tax', 'Federal Tax', 'Gov Fine', 'Misc. Deduction', 'State Tax Refund', 'Federal Tax Refund'
    };
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
