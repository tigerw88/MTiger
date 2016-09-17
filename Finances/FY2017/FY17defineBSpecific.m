%% defineBSpecific

BSpecific = Budget('Detailed Budget', '2016-10-01', 12);

BSpecific = addGroup(BSpecific, 'Dining', -400*12, ...
    {'Restaurants', 'Coffee Shops', 'Alcohol & Bars'});

BSpecific = addGroup(BSpecific, 'Living', -250*12, ...
    {'Groceries', 'Home Supplies', 'Pharmacy'});

BSpecific = addGroup(BSpecific, 'Driving', -70*12, ...
    {'Gas & Fuel', 'Parking', 'Public Transportation', 'Public Rail'});

BSpecific = addGroup(BSpecific, 'Personal Discretionary', -1500, ...
    {'Movies & DVDs', 'Books', 'Music', 'Arts', 'Electronics & Software', 'Mobile Phone', ...
    'Amusement', 'Park Fees & Camping', 'Sporting Events', ...
    'Education', 'Charity', 'Shipping', 'Misc Items', 'Gift', 'Sports', 'Vacation'});

BSpecific = addGroup(BSpecific, 'Gym', -100*12, {'Gym'});

BSpecific = addGroup(BSpecific, 'Housing', -(750*12), ...
    {'Mortgage & Rent', 'Utilities', 'Internet', 'Trash Service', 'Water'});

BSpecific = addGroup(BSpecific, 'Shopping', -4000, ...
    {'Shopping', 'Sporting Goods', 'Clothing', 'Bike Service Parts', 'Home', 'Furnishings'});

BSpecific = addGroup(BSpecific, 'Auto', -1500, ...
    {'Auto Insurance', 'Service & Parts', 'Car Fees'});

BSpecific = addGroup(BSpecific, 'Travel', -250*12, ...
    {'Air Travel', 'Rental Car & Taxi', 'Travel'});

BSpecific = addGroup(BSpecific, 'Taxes', -60000*0.33, ...
    {'State Tax', 'Federal Tax', 'Gov Fine', 'Misc. Deduction', 'State Tax Refund', 'Federal Tax Refund'});

BSpecific = addGroup(BSpecific, 'Salary', 60000, {'Paycheck', 'Salary'});

BSpecific = addGroup(BSpecific, 'Other Income', 40000*0.009, {'Income', 'Interest Income', 'Gift Received'});

BSpecific = addGroup(BSpecific, 'Per Diem', 2000, {'Per Diem'});

BSpecific = addGroup(BSpecific, 'Savings', 0, {'TSP'});

BSpecific = addGroup(BSpecific, 'Benefits', 60000*0.03, {'TSP Matched'});