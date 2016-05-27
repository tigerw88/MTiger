function T = assignBudgetCat(T, B)
% ASSIGNBUDGETCAT Assign each transaction to a category based on the Mint
% category and the rules defined in the budget.
%
% INPUT
% + T - Table of transactions
% + B - Budget
%
%

for n = 1:numel(B.BudgetCategory)
    
    BC = B.BudgetCategory(n);
    
    for k = numel(B.BudgetCategoryCategories{n})
    
    
    end
    
end


% for k = 1:numel(BT) % for each budget type
%     
%     BC = BT(k).BudgetCat; % extract the k-th budget category
%     
%     for n = 1:numel(BC) % for each budget category in this budget type
%                 
%         categories = BC(n).Categories; % extract the Mint categories that pertain to this budget category
% 
%         for i = 1:numel(categories) % for each of the Mint categories that belongs to this budget category
%             
%             idx = strcmp(T.Category, categories{i}); % find the applicable transactions
%             T{idx, 'BudgetType'} = {BT(k).Name}; % assign the budget type
%             T{idx, 'BudgetCat'} = {BC(n).Name}; % assign the budget category
%             
%         end
%         
%     end
%     
% end

end