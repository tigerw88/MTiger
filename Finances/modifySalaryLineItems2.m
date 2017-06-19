function [ALLT] = modifySalaryLineItems2( ALLT )
% MODIFYSALARYLINEITEMS2
%
% KEY VARIABLES
% ALLT -  the original table of all transactions
% PAYCHECKS -  table with only 'Paycheck' transactions
% SPLITS -  table with r rows that contains all of the splits for a single
% 'Paycheck' transaction
%
% PROCESS
% Create PAYCHECKS from ALLT.
% For each occurence of PAYCHECKS, create a new & temporary SPLITS.
% After SPLITS is created, add SPLITS to ALLT.
% After a new SPLITS is added to ALLT for each PAYCHECKS, remove all As from ALLT.
%

%{

GROSS PAY
Salary

DEDUCTIONS
Fed Tax : {Tax}
Health Benefits : {?}
Retirement - FERS/FRAE : {Savings}
Medicare : {?}
State Tax : {Tax}
TSP Savings : {Savings}
OASDI Tax : {Tax}
FEGLI - Regular : {?}

BENEFITS (paid by Government)
FEGLI : {?}
Medicare : {?}
TSP Basic : {Benefits} >> Transfer to Savings
FERS/FRAE : {Benefits} >> Transfer to Savings
FEHB : {?}
OASDI : {?}
TSP Matching : {Benefits} >> Transfer to Savings

%}

%%

% Transactions that are labelled Paycheck
PAYCHECKS = ALLT(strcmp(ALLT.Category,'Paycheck'), :); 

% # of new categories
nc = 16; 

for n = 1:numel(PAYCHECKS.Date) % for each transaction
    
        for j=1:nc
            SPLITS(j, :) = PAYCHECKS(n, :);
        end
        
        SPLITS.Category(1) = {'Salary'};

        % Deductions
        SPLITS.Category(2) = {'Federal Tax'};
        SPLITS.Category(3) = {'Health Benefits'};
        SPLITS.Category(4) = {'Retirement - FERS/FRAE'};
        SPLITS.Category(5) = {'Medicare'};
        SPLITS.Category(6) = {'State Tax'};
        SPLITS.Category(7) = {'TSP Savings'};
        SPLITS.Category(8) = {'OASDI Tax'};
        SPLITS.Category(9) = {'FEGLI - Regular'};
        SPLITS.TransactionType(2:9) = {'debit'}; % change these transactions to 'debit'
        
        % Benefits
        SPLITS.Category(10) = {'FEGLI'};
        SPLITS.Category(11) = {'Medicare Benefit'};
        SPLITS.Category(12) = {'TSP Basic'};
        SPLITS.Category(13) = {'FERS/FRAE'};
        SPLITS.Category(14) = {'FEHB'};
        SPLITS.Category(15) = {'OASDI'};
        SPLITS.Category(16) = {'TSP Matching'};
    
    % Sep 15, 2015 - Sep 29, 2015
    if floor(PAYCHECKS.Amount(n)) == floor(1687.6)
        
        SPLITS.Amount = [2366.40 313.04 0 104.12 34.31 0 70.99 146.71 9.60 ...
            4.80 34.31 23.66 262.67 0 146.71 70.99]';
        
    % Oct 13, 2015
    elseif PAYCHECKS.Amount(n) == 1534.75
        
        SPLITS.Amount = [2366.40 313.04 0 104.12 34.31 152.87 70.99 146.71 9.60 ...
            4.80 34.31 23.66 262.67 0 146.72 70.99]';
       
    % Oct 27, 2015 - Jan 19, 2016
    elseif PAYCHECKS.Amount(n) == 1470.42
        
        
        SPLITS.Amount = [2366.40 287.03 56.71 104.12 33.49 143.51 118.32 143.20 9.60 ...
            4.80 33.49 23.66 281.60 170.15 143.20 94.66]';

    % Feb 2, 2016 - present
    elseif floor(PAYCHECKS.Amount(n)) == floor(1485.4)

        SPLITS.Amount = [2396.80 292.07 60.04 105.46 33.88 145.51 119.84 144.88 9.75 ...
            4.88 33.88 23.97 285.22 180.11 144.88 95.87]';
        
    % Percentage estimates based on Feb 2, 2016 information
    else
        
        SPLITS.Amount = [2396.80 292.07 60.04 105.46 33.88 145.51 119.84 144.88 9.75 ...
            4.88 33.88 23.97 285.22 180.11 144.88 95.87]';
        SPLITS.Amount = SPLITS.Amount / 1485 * PAYCHECKS.Amount(n);

    end
    
    
    
    
    ALLT = [ALLT; SPLITS]; % Add new line items to the original table


end


%%

% Remove all Paycheck transactions
ALLT(strcmp(ALLT.Category,'Paycheck'), :) = [];











