function T = assignBudgetCat(T, B)
%

for n = 1:numel(B)
    
   categories = B(n).Categories;
   for i = 1:numel(categories)
       
       idx = strcmp(T.Category, categories{i});
       T{idx, 'BudgetCat'} = {B(n).Name};
       
   end
        
end



end