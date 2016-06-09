function listTransactions(T)
% LISTTRANSACTIONS List all transactions in a table
%
% USAGE:
% >>listTransactions( T(strcmp(T.Group, 'Taxes'), :) )
%

T = sortrows(T, 'Date', 'descend');
T(:, {'Date', 'Description', 'Amount', 'Group', 'Category'})
