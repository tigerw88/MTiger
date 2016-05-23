
['Expected Savings this Year: $' num2str(sum(extractfield(B, 'Amount'))*-1)]

for n = 1:numel(B)
    
    
    totalspent = sum(T{strcmp(T.BudgetCat, B(n).Name), 'Amount'});
    budgetpercent = totalspent / B(n).Amount;
    percenttime = (datenum(max(T.Date)) - datenum(min(T.Date)))/365;
    plusminuspercent = (budgetpercent / percenttime) * 100;
    data(n) = totalspent / B(n).Amount;
    label{n} = B(n).Name;
    
    summarystr = [B(n).Name ': $' num2str(totalspent) ' of $' num2str(B(n).Amount) ' ('  num2str(plusminuspercent)  '% compared to pace)'];
    
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
