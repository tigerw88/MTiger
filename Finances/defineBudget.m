function BudgetCat = defineBudget()

Budget.Type = 'Annual';

%%

BudgetType = 'Monthly Expense';
n = 0;

    %
n = n+1;
BudgetCat(n).Name = 'Dining';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 400*12;
BudgetCat(n).Categories = {'Restaurants', 'Coffee Shops', 'Alcohol & Bars'};

    %
n = n+1;
BudgetCat(n).Name = 'Living';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 250*12;
BudgetCat(n).Categories = {'Groceries', 'Home Supplies', 'Pharmacy'};

    %
n = n+1;
BudgetCat(n).Name = 'Driving';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 70*12;
BudgetCat(n).Categories = {'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail'};

    %
n = n+1;
BudgetCat(n).Name = 'Pers. Discretionary';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 250*12;
BudgetCat(n).Categories = {...
    'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation'};
% What to do about 'Vacation'?


    %
n = n+1;
BudgetCat(n).Name = 'Gym';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 100*12;
BudgetCat(n).Categories = {'Gym'};
% Most of 'Sports' transactions should be changed to 'Gym'





%% 

BudgetType = 'Annual Expense';

    %
n = n+1;
BudgetCat(n).Name = 'Housing';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = (1250*9 + 1000*3);
BudgetCat(n).Categories = {'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water'};

    %
n = n+1;
BudgetCat(n).Name = 'Shopping';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 3000;
BudgetCat(n).Categories = {'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service &amp; Parts', 'Home', 'Furnishings'};

    %
n = n+1;
BudgetCat(n).Name = 'Auto';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 1500;
BudgetCat(n).Categories = {'Auto Insurance', 'Service & Parts'};

    %
n = n+1;
BudgetCat(n).Name = 'Travel';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 250*12;
BudgetCat(n).Categories = {'Air Travel', 'Rental Car & Taxi', 'Travel'};

    %
n = n+1;
BudgetCat(n).Name = 'Taxes';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = 60000*0.2;
BudgetCat(n).Categories = {'State Tax', 'Federal Tax', 'Gov Fine'};



%% 

BudgetType = 'Annual Income';

    %
n = n+1;
BudgetCat(n).Name = 'Salary';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = -60000;
BudgetCat(n).Categories = {'Paycheck'};

    %
n = n+1;
BudgetCat(n).Name = 'Other Income';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = -60000;
BudgetCat(n).Categories = {'Income', 'Interest Income', 'Gift Received'};

    %
n = n+1;
BudgetCat(n).Name = 'Per Diem';
BudgetCat(n).BudgetType = BudgetType;
BudgetCat(n).Amount = -60000;
BudgetCat(n).Categories = {'Per Diem'};



%% 

% What to do about --> 'Furnishigs', 'Business Services', 'Security
% Deposit', 'Cash & ATM', 'Travel', 'Vacation', 'Fees & Charges'
% Corrections --> 'Sports' to 'Gym', 'Eisenhowser Bagel' transaction,
% 'Shopping'
% 'China East' transaction

%%
end
