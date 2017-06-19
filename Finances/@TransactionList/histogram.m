function h = histogram( obj )
%HISTOGRAM Histogram of transactions by amount
%
% >> histogram( T )
% % histogram of transactions by amount
%

%%

data = obj.T{:, 'Amount'};
h = histogram(data);
ylabel('No. of Transactions in Bin')
xlabel('Transaction Amount ($)')
title('Histogram of Transactions by Amount')

% legend('No. of Events')

end

