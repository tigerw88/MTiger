classdef BudgetGroup
    %BUDGETGROUP

    %%
    
    properties
        
        name;
        amount;
        mint_cat;
        
    end
    
    methods
        
        function obj = BudgetGroup(name, amount, categories)
        
            obj.name = name;
            obj.amount = amount;
            obj.mint_cat = categories;
            
        end
            
    end
    
    methods
        
        function disp(this)
            
            for i = 1:numel(this)
                
                obj = this(i);
                
                disp(' ')
                fprintf('  %s ($%6.0f) with Mint Categories:\n', upper(obj.name), obj.amount)
                for n = 1:numel(obj.mint_cat)
                    fprintf('      %s\n', obj.mint_cat{n})
                end
                disp(' ')
                
            end
            
        end
        
    end
    
end

