function [ ActualGroupAmount ] = generateReport( T, B )
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
% OUTPUT
% + ActualGroupAmount - an n-by-m matrix of amounts spent/earned for each
% group for each month in the budget. n corresponds to the number of
% groups, and m corresponds to the number of months.
%

display('Generating Report...')

%% Settings

    % display dollar amounts or percent of budget
R.type = 'amounts'; % {'amounts'} | 'scaled'


%% 

G = B.Group;

for n = 1:numel(G)
    
    this_group = G{n};
    
    for m = 2:numel(B.BudgetDates)
    
        ridx = T.Date >= B.BudgetDates(m-1) & T.Date < B.BudgetDates(m) & strcmp(T.Group, this_group);
        ActualGroupAmount(n, m) = sum(T{ridx, 'Amount'});

    end
    
end

%% Everything

% fh(1) = figure;
% ax(1) = subplot(1,1,1);
% barh(sum(ActualGroupAmount(:,:)'))
% ax(1).YTickLabel = B.Group;
% 
% hold on;
% 
% plot(abs(B.BudgetAmount),1:numel(G), 'or')


%% Expenses

fh(2) = figure;
idx.exp = find(B.GroupExpInc==-1);
ax(1) = subplot(2,1,1);
barh( abs(sum(ActualGroupAmount(idx.exp,:)')), 'r' ); % Do the sum first so that if there are + and - expenses in a group, they are handled appropriately
% barh( abs(ActualGroupAmount(idx.exp,:)'), 'stacked' ); % Do the sum first so that if there are + and - expenses in a group, they are handled appropriately
ax(1).Title.String = 'Expenses';
ax(1).YTickLabel = B.Group(idx.exp);

hold on;

perc_of_year = (datenum(datevec(max(T.Date))) - datenum(datevec(B.BudgetDates(1))))/(12*30.5);
plot(abs(B.BudgetAmount(idx.exp)),1:numel(idx.exp), 'ok', 'MarkerFaceColor', 'k');
plot(abs(B.BudgetAmount(idx.exp))*perc_of_year,1:numel(idx.exp), '*k');

%% Income

idx.inc = find(B.GroupExpInc==1);
ax(2) = subplot(2,1,2);
barh(sum(ActualGroupAmount(idx.inc,:)'), 'g');
ax(2).Title.String = 'Income';
ax(2).YTickLabel = B.Group(idx.inc);

hold on;

plot(abs(B.BudgetAmount(idx.inc)),1:numel(idx.inc), 'ok', 'MarkerFaceColor', 'k');


% Link axes for Expenses and Income so that they are plotted on same scale
ax(1).XLim = ax(2).XLim;

%% Ratio

    % Pie charts of Savings and Expenses - Budgeted and Actual
fh(3) = figure;

    % Budgeted
salaryidx = find(strcmp(B.Group, 'Salary'));    
    
pieax(1) = subplot(2,1,1);
labels = {'Savings', 'Expenses'};
budgeted_income = B.BudgetAmount(salaryidx); % this is the one that pertains to Salary
budgeted_expenses = sum(abs(B.BudgetAmount(idx.exp,:)'));
budgeted_savings = budgeted_income - budgeted_expenses;
phB = pie([budgeted_savings budgeted_expenses]);
colormap([0 1 0; 1 0 0])
legend(labels,'Location','southoutside','Orientation','horizontal');
title({'Budgeted Savings as a % of Salary';['Total Income: $' num2str(budgeted_income)]});

    % Actual
pieax(2) = subplot(2,1,2);
labels = {'Savings', 'Expenses'};
% total_income = sum(sum(ActualGroupAmount(idx.inc,:)'));
total_income = sum(sum(ActualGroupAmount(salaryidx,:)')); % this is the one that pertains to Salary
total_expenses = abs(sum(sum(ActualGroupAmount(idx.exp,:)')));
total_savings = total_income - total_expenses;
phA = pie([total_savings total_expenses]);
colormap([0 1 0; 1 0 0])
legend(labels,'Location','southoutside','Orientation','horizontal');
title({'Actual Savings as a % of Salary';['Total Income: $' num2str(total_income)]});


%% This section needs work.
% The category labels do not match what they are supposed to.

figure
idx.exp = find(B.GroupExpInc==-1);
ax(1) = subplot(1,1,1);
barh(abs(ActualGroupAmount),'stacked')
ax(1).Title.String = 'Expenses';
ax(1).YTickLabel = B.Group;


end