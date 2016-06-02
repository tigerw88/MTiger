function listTransactions(T)

T = sortrows(T, 'Date', 'descend');
T(:, {'Date', 'Description', 'Amount', 'Group', 'Category'})
