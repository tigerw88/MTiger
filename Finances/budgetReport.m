function budgetReport(T, B)

%% Things we want to know:

    % data
    
days_passed = (datenum(max(T.Date)) - datenum(min(T.Date)));
perc_time_passed = days_passed / 365;
    
% total_monthly_spent;
% total_annual_spent;
% TOTAL_SPENT;

% salary_earned;
% other_income_earned;
% TOTAL_EARNED;


    % derivatives

% SALARY_SAVED = salary_earned - TOTAL_SPENT;
% TOTAL_SAVED = TOTAL_EARNED - TOTAL_SPENT;
% 
% EXPECTED_SAVINGS = TOTAL_SAVED / days_passed * 365;


%%

for k = 1:numel(B)
    
    switch B(k).Name
        
        case 'Monthly Expense'
            
            [monthly_exp] = compareBudget2Actual(T, B(k), perc_time_passed);
            
        case 'Annual Expense'
            
            [annual_exp] = compareBudget2Actual(T, B(k), perc_time_passed);
            
        case 'Annual Income'
            
            [income] = compareBudget2Actual(T, B(k), perc_time_passed);
            
        otherwise
            
            
    end
    
end


%% Figures

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


%% Internal Functions

    function this_type = compareBudget2Actual(T, budget_type, percenttime)
        
        BC = budget_type.BudgetCat; % Extract Budget Categories for this type
        
        for n = 1:numel(BC)
            
            this_type.labels{n} = BC(n).Name;
            this_type.totalspent(n) = sum(T{strcmp(T.BudgetCat, BC(n).Name), 'Amount'});
            this_type.budgetpercent(n) = this_type.totalspent(n) / BC(n).Amount;
            this_type.plusminuspercent(n) = (this_type.budgetpercent(n) / percenttime) * 100;
            
            this_type.summarystr = [BC(n).Name ': $' num2str(this_type.totalspent(n)) ' of $' num2str(BC(n).Amount) ' ('  num2str(this_type.plusminuspercent(n))  '% compared to pace)'];
            
            display('------------------------')
            display(this_type.summarystr)
            
        end
        
    end

%%
end