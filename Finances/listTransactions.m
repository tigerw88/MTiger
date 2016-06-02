function listTransactions(T)

T(:, {'Date', 'Description', 'Amount', 'Group', 'Category'});
sortrows(T, 'Date', 'descend')
