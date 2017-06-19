function T = filterTransactions(T)
% FILTERTRANSACTIONS Designed specifically for my desired implementation


%% Filter Down to Desired Transaction

display('----------------------------------------------------------------')
display('  Filtering original transactions...')

    % filter by TransactionType
idx.type = strcmp(T.TransactionType,'debit') ...
    | strcmp(T.TransactionType, 'credit');
display('   Credit and debit transactions only - i.e., no money transfers.')

idx.reimbursable = ~(contains(T.Labels, 'Reimbursable') ...
    | contains(T.Labels, 'USGS Reimbursable') ...
    | contains(T.Labels, 'NTU Reimbursable') ...
    | contains(T.Labels, 'Returned'));
display('   Reimbursable expenses, reimbursements, and returned items removed.')

idx.refund = ~(strcmp(T.Labels, 'Refund'));
display('   Refunded expenses and refunds removed.');

    % input/output
idx.io = ~(strcmp(T.Category, 'Credit Card Payment') ...
    | strcmp(T.Category, 'Transfer') ...
    | strcmp(T.Category, 'Transfer for Cash Spending') ...
    | strcmp(T.Category, 'Financial') ...
    | strcmp(T.Category, 'Cash & ATM') ...
    | strcmp(T.Category, 'Reimbursement') ...    
    );
display('   Transactions from the following categories have been removed:')
display('    - Credit Card Payment')
display('    - Transfer')
display('    - Transfer for Cash Spending')
display('    - Financial')
display('    - Cash & ATM')
display('    - Reimbursement')

    % apply the filter
r = (idx.type & idx.reimbursable & idx.refund & idx.io);
T = T(r, :);

end