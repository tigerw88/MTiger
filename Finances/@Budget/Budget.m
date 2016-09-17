classdef Budget
    %BUDGET
    %
    % see also BudgetGroup

    
    properties
        
        name;
        start;
        nmonths
        groups; % series of BudgetGroup objects
        
    end
    
    properties (Dependent)
        
        budget_dates;
        balance; % income - expenses; abs() of all budget group amounts
        balance_as_perc_income; % balance as a percent of all positive group amounts
        
    end
    
    methods
        
        
        function val = get.budget_dates(obj)
            
           val = [obj.start obj.start + calmonths(1:obj.nmonths-1)];
            
        end
        
        % get the budget's balance - abs() of all budget group amounts
        function val = get.balance(obj)
           
            val = 0;
            for n = 1:numel(obj.groups)
                
               val = val + obj.groups(n).amount;
                
            end
            
        end
        
        % get the balance as a percent of the budget's positive amounts
        % this could also be thought of as savings as a percent of all
        % income
        function val = get.balance_as_perc_income(obj)
        
            income = 0; % initialize value for all income (all positive amounts)
            for n = 1:numel(obj.groups)
               
                if obj.groups(n).amount > 0;
                    income = income + obj.groups(n).amount;
                end
                
            end
            val = obj.balance / income;
        
        end
    end
    
    methods
        
        % Budget class constructor
        function obj = Budget(name, start, nmonths, varargin)
            
            obj.name = name;
            obj.start = datetime(start);
            obj.nmonths = nmonths;
            
            if nargin==4 % assume 4th input argument is a list of budget groups
                % append the list of budget groups
                % 4th input argument is the 1st variable input argument
                obj.groups = [obj.groups varargin{1}]; 
            end
            
        end
        
        % Adds a Budget Group to a pre-existing budget
        function obj = addGroup( obj, group_name, group_amount, group_cats)
            
            G = BudgetGroup( group_name, group_amount, group_cats);
           obj.groups = [obj.groups G];
            
        end
        
    end
    
    %% Display Methods
    
    methods
        
        % disp overload function for Budget class
        function disp(obj)
            
            if numel(obj) > 1; 
                error('Only 1 Budget can be displayed at a time.');
            end
            
            disp(' ')
            fprintf('  %s\n', upper(obj.name))
            fprintf('    %s - %s (%i months)\n', ...
                datestr(obj.start, 'yyyy-mmm'), ...
                datestr(obj.budget_dates(end), 'yyyy-mmm'), ...
                obj.nmonths);
            disp(' ')
            fprintf('    with groups:\n')
            for n = 1:numel(obj.groups)
               fprintf(' %25s : $%10.2f\n', ...
                   obj.groups(n).name, obj.groups(n).amount); 
            end
            fprintf(' %25s   %11s\n', ' ', '----------');
            fprintf(' %25s   $%10.2f\n', ' ', obj.balance);
            fprintf(' %25s -->   (%3.1f%%)\n', 'Savings', ...
                obj.balance_as_perc_income * 100);
            disp(' ')
            
        end
        
        % Creates a pie chart of all budgeted income, expenses, and what's
        % leftover
        function pie(obj)
            
%             pieax = axes;
            figure;
            labels = {'Leftover', 'Expenses'};
            
            income = 0; expense = 0;
            for n = 1:numel(obj.groups)
                
                if obj.groups(n).amount > 1,
                    income = income +  obj.groups(n).amount;
                elseif obj.groups(n).amount < 1,
                    expense = expense + abs(obj.groups(n).amount);
                end
                
            end
            savings = income - expense;
            pie([savings expense]);
            colormap([0 1 0; 1 0 0])
            legend(labels, ...
                'Location','southoutside','Orientation','horizontal');
            title({['Budget: ' obj.name]; ...
                'Savings as a % of Income'; ...
                ['Total Income: $' num2str(income)]});
            
            
        end
        
    end
    
    %%
    
end

