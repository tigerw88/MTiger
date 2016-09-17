function [T] = modifySalaryLineItems2( T )
% MODIFYSALARYLINEITEMS2
%
%
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

% 
A = T(strcmp(T.Category,'Paycheck'), :); % Transactions that are labelled Paycheck

nc = 16; % # of new categories

for n = 1:numel(A.Date) % for each transaction
    
        for j=1:nc
            B(j, :) = A(n, :);
        end
        
        B.Category(1) = {'Salary'};

        % Deductions
        B.Category(2) = {'Federal Tax'};
        B.Category(3) = {'Health Benefits'};
        B.Category(4) = {'Retirement - FERS/FRAE'};
        B.Category(5) = {'Medicare'};
        B.Category(6) = {'State Tax'};
        B.Category(7) = {'TSP Savings'};
        B.Category(8) = {'OASDI Tax'};
        B.Category(9) = {'FEGLI - Regular'};
        
        % Benefits
        B.Category(10) = {'FEGLI'};
        B.Category(11) = {'Medicare'};
        B.Category(12) = {'TSP Basic'};
        B.Category(13) = {'FERS/FRAE'};
        B.Category(14) = {'FEHB'};
        B.Category(15) = {'OASDI'};
        B.Category(16) = {'TSP Matching'};
    
    % Sep 15, 2015 - Sep 29, 2015
    if floor(A.Amount(n)) == floor(1687.6)
        
        B.Amount = [2366.40 313.04 0 104.12 34.31 0 70.99 146.71 9.60 ...
            4.80 34.31 23.66 262.67 0 146.71 70.99]';
        
    % Oct 13, 2015
    elseif A.Amount(n) == 1534.75
        
        B.Amount = [2366.40 313.04 0 104.12 34.31 152.87 70.99 146.71 9.60 ...
            4.80 34.31 23.66 262.67 0 146.72 70.99]';
       
    % Oct 27, 2015 - Jan 19, 2016
    elseif A.Amount(n) == 1470.42
        
        
        B.Amount = [2366.40 287.03 56.71 104.12 33.49 143.51 118.32 143.20 9.60 ...
            4.80 33.49 23.66 281.60 170.15 143.20 94.66]';

    % Feb 2, 2016 - present
    elseif floor(A.Amount(n)) == floor(1485.4)

        B.Amount = [2396.80 292.07 60.04 105.46 33.88 145.51 119.84 144.88 9.75 ...
            4.88 33.88 23.97 285.22 180.11 144.88 95.87]';
        
    % Percentage estimates based on Feb 2, 2016 information
    else
        
        B.Amount = [2396.80 292.07 60.04 105.46 33.88 145.51 119.84 144.88 9.75 ...
            4.88 33.88 23.97 285.22 180.11 144.88 95.87]';
        B.Amount = B.Amount / 1485 * A.Amount(n);

    end
    
    T = [T; B]; % Add new line items to the original table


end


%%

% Remove all Paycheck transactions
T(strcmp(T.Category,'Paycheck'), :) = [];











