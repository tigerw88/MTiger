classdef TransactionList
    %TRANSACTIONLIST Holds all info related to a list of transactions

    %%
    
    properties (Access = private)
    
        T; % table of transactions
        B = Budget('Default', '1988-03-17', 12); % budget associated with assigning groups
        
    end
    
    %% constructor/get/set methods
    
    methods
        
        % constructor method for the TransactionList class
        function obj = TransactionList( table, budget)
            
            obj.T = table;
            obj.B = budget;
            
        end
        
        % Sets a property for the transaction list
        function obj = set( obj, prop, input )
        
            switch prop
                
                case 'table'
                    
                    obj.T = input;
                    
                case 'Budget'
                    
                    display('   Assigning budget to transaction list...')
                    obj.B = input;
                    
                    if ~isempty(obj.T)
                        display('   Assigning budget groups to transactions...')
                        assignBudgetGroup(obj, input);
                        display('   ...Transaction groups updated.')
                    end
                    
                otherwise
                    
            end
            
        end
        
        % get a property from the transaction list
        function val = get( obj, prop )
            
           switch prop
               
               case 'table'
                   
                   val = obj.T;
                   
               case 'Budget'
                   
                   val = obj.B;
                   
               otherwise
                   
           end
            
        end
        
    end
    
    %% display methods

    methods
        
        function disp( obj )
            
            display(' ')
            display('List of Transactions from x to x')
            fprintf('   Grouped based on Budget: %s\n', obj.B.name)
            
            obj.T = sortrows(obj.T, 'Date', 'descend');
            obj.T(:, {'Date', 'Description', 'Amount', 'Group', 'Category'})
            
        end
        
        
    end
    
end

