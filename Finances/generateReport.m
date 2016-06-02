function [ GroupAmount ] = generateReport( T, B )
%GENERATEREPORT Summarizes and plots actual spending vs. budget
%
% INPUT
% + T - table of transactions
% + B - budget
%
% HARD-CODED
% + indices for which groups and categories are expenses vs. income are
% currently hard-coded in here. Obviously, that needs to change.
%

display('Generating Report...')

%% Settings

R.type = 'amounts'; % {'amounts'} | 'scaled'




%% 

G = B.Group;

for n = 1:numel(G)
    
    this_group = G{n};
    
    for m = 2:numel(B.BudgetDates)
    
        ridx = T.Date >= B.BudgetDates(m-1) & T.Date < B.BudgetDates(m) & strcmp(T.Group, this_group);
        GroupAmount(n, m) = sum(T{ridx, 'Amount'});

    end
    
end

%% Everything

% fh(1) = figure;
% ax(1) = subplot(1,1,1);
% barh(sum(GroupAmount(:,:)'))
% ax(1).YTickLabel = B.Group;
% 
% hold on;
% 
% plot(abs(B.BudgetAmount),1:numel(G), 'or')


%% Expenses

fh(2) = figure;
idx.exp = 1:10;
ax(1) = subplot(2,1,1);
barh(sum(GroupAmount(idx.exp,:)'), 'r');
% barh((GroupAmount(idx.exp,:)'), 'stacked')
ax(1).Title.String = 'Expenses';
ax(1).YTickLabel = B.Group(idx.exp);

hold on;

perc_of_year = (datenum(datevec(max(T.Date))) - datenum(datevec(B.BudgetDates(1))))/(12*30.5);
plot(abs(B.BudgetAmount(idx.exp)),1:numel(idx.exp), 'ok', 'MarkerFaceColor', 'k');
plot(abs(B.BudgetAmount(idx.exp))*perc_of_year,1:numel(idx.exp), '*k');

%% Income

idx.inc = 11:13;
ax(2) = subplot(2,1,2);
barh(sum(GroupAmount(idx.inc,:)'), 'g');
ax(2).Title.String = 'Income';
ax(2).YTickLabel = B.Group(idx.inc);

hold on;

plot(abs(B.BudgetAmount(idx.inc)),1:numel(idx.inc), 'ok', 'MarkerFaceColor', 'k');

%% Ratio

    % Pie charts of Savings and Expenses - Budgeted and Actual
fh(3) = figure;

    % Budgeted
pieax(1) = subplot(2,1,1);
labels = {'Savings', 'Expenses'};
budgeted_income = B.BudgetAmount(11); % this is the one that pertains to Salary
budgeted_expenses = sum(abs(B.BudgetAmount(idx.exp,:)'));
budgeted_savings = budgeted_income - budgeted_expenses;
pie([budgeted_savings budgeted_expenses]);
legend(labels,'Location','southoutside','Orientation','horizontal');
title({'Budgeted Savings as a % of Income';['Total Income: $' num2str(budgeted_income)]});

    % Actual
pieax(2) = subplot(2,1,2);
labels = {'Savings', 'Expenses'};
total_income = sum(sum(GroupAmount(idx.inc,:)'));
total_expenses = sum(sum(GroupAmount(idx.exp,:)'));
total_savings = total_income - total_expenses;
pie([total_savings total_expenses]);
legend(labels,'Location','southoutside','Orientation','horizontal');
title({'Actual Savings as a % of Income';['Total Income: $' num2str(total_income)]});


end