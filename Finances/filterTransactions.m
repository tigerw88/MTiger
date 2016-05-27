function T = filterTransactions(T)


%% Filter Down to Desired Transaction

    % filter by date
idx.date = T.Date > '09/01/2015' & T.Date <= '05/31/2016';

    % filter by TransactionType
idx.type = strcmp(T.TransactionType,'debit') ...
    | strcmp(T.TransactionType, 'credit');

idx.reimbursable = ~(strcmp(T.Labels, 'Reimbursable') ...
    | strcmp(T.Labels, 'USGS Reimbursable') ...
    | strcmp(T.Labels, 'NTU Reimbursable'));

    % input/output
idx.io = ~(strcmp(T.Category, 'Credit Card Payment') ...
    | strcmp(T.Category, 'Transfer') ...
    | strcmp(T.Category, 'Transfer for Cash Spending') ...
    | strcmp(T.Category, 'Financial') ...
    | strcmp(T.Category, 'Cash & ATM') ...
    | strcmp(T.Category, 'Reimbursement') ...    
    );


    % apply the filter
r = (idx.date & idx.type & idx.reimbursable & idx.io);
T = T(r, :);

%% Split into Budget Categories






end