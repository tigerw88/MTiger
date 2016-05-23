
['Expected Savings this Year: $' num2str(sum(extractfield(B, 'Amount'))*-1)]

for n = 1:numel(B)
    
    
    totalspent(n) = sum(T{strcmp(T.BudgetCat, B(n).Name), 'Amount'});
    budgetpercent = totalspent(n) / B(n).Amount;
    percenttime = (datenum(max(T.Date)) - datenum(min(T.Date)))/365;
    plusminuspercent = (budgetpercent / percenttime) * 100;
    data(n) = totalspent(n) / B(n).Amount;
    label{n} = B(n).Name;
    
    summarystr = [B(n).Name ': $' num2str(totalspent(n)) ' of $' num2str(B(n).Amount) ' ('  num2str(plusminuspercent)  '% compared to pace)'];
    
    display('------------------------')
    display(summarystr)
    
end

%%

close all
figure
p = barh(abs(data));
hold on
xlim([0 1.5])
ylim([0 numel(B)+1])
plot([percenttime percenttime], [0 numel(B)+1], 'r--')
plot([1 1], [0 numel(B)+1], 'r-')
set(gca,'YTickLabel',label)
title('Year to Date Spending')

%%

figure
p2 = barh(totalspent(1:end-4));
hold on
% xlim([0 1.5])
% ylim([0 numel(B)+1])
plot(percenttime*abs([B(1:end-4).Amount]), 1:numel(B)-4, 'r*')
plot(abs([B(1:end-4).Amount]), 1:numel(B)-4, 'ro')
set(gca,'YTickLabel', {label{1:end-4}})
title('Dollars Spending')

%%

% figure
% x = [sum(abs(totalspent(1:end-4))) sum(abs(totalspent(end-2)))-sum(abs(totalspent(1:end-4)))]
% pie(x)
