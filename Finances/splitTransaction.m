function B = splitTransaction( T, categories, amounts, type )
% SPLITTRANSACTION Splits a transaction into multiple categories
% This function could also be used to change a category name
%
% INPUT
% + T - table that holds the transactions
% + trans - 
% + categories - {n-by-1} list of desired categories (must include original
% category if you want it to still be included)
% + amounts - [n-by-1] list of amounts corresponding to each category
% + type - 'dollars' | 'percent' - replaces original amount as new dollar
% amount or percentage of existing dollar amount
%
% OUTPUT
% + T2 - modified table with split transactions
%
% HARD-CODED
%
%
%

%% parse input

    % check to make sure categories and amounts are equal in length
if ~(size(categories)==size(amounts)), error('Number of categories does not match number of amounts.'); end
if numel(unique(findgroups(T.Category))) > 1, error('Not all categories are the same'); end;

switch type
    
    case 'dollars'
        
%         original_amount = 
%         if ~(original_amount==sum(amounts)), warning('Split amounts do not equal original amounts.'); end
        
    case 'percent'
        
        percdiff = amounts-1;
        if ~(sum(percdiff)==0), error('Split amounts do not equal 100%.'); end
        
    otherwise
        
        error('Type of split not understood. Use ''dollars'' or ''percent''.')
    
    
end

%%

original_category = T.Category(1);
T{:, 'Category'} = strrep(T{:, 'Category'}, original_category, 'original_category');

B = T;
startidx = 1:size(T,1):size(T,1)*numel(categories);
stopidx = size(T,1):size(T,1):size(T,1)*numel(categories);

for n=1:numel(categories)
    
    B = [B; T];
    B{startidx(n):stopidx(n), 'Category'} = ...
        strrep(B{startidx(n):stopidx(n), 'Category'}, 'original_category', categories(n));
    
    switch type
        
        case 'percent'
            
            B{startidx(n):stopidx(n), 'Amount'} = B{startidx(n):stopidx(n), 'Amount'}*amounts(n);
            
        case 'dollars'
            
            B{startidx(n):stopidx(n), 'Amount'} = amounts(n);

            
    end
    
    %     display(B); pause; clc;
    
    
end;
B(stopidx(end)+1:end, :) = [];


%%
% 
% original_category = T.Category(1);
% 
% 
% 
% T2 = T;
% T2{:, 'Category'} = strrep(T2{:, 'Category'}, original_category, 'original_category');
% 
% 
% for n = 1:numel(categories)
%     
%     T2 = [T2; T];
%     T2{:, 'Category'} = strrep(T2{:, 'Category'}, 'original_category', categories(n));
%     
%     switch type
%         
%         case 'dollars'
%             
%             T2{:, 'Amount'} = amounts(n);
%                  
%         case 'percent'
%             
%             T2{:, 'Amount'} = T2{:, 'Amount'}*amounts(n);
%                  
%     end
%     
% 
%     
% end
% 
%     % remove all of the original transactions
% T2(strcmp(T2.Category, 'original_category'), :) = [];

%%

% Tnet = T(strcmp(T.Category, 'Paycheck'), :);
% Tsalary = T(strcmp(T.Category, 'Paycheck'), :);
% Tsalary{:, 'Category'} = strrep(Tsalary{:, 'Category'}, 'Paycheck', 'Salary');
% Ttax = T(strcmp(T.Category, 'Paycheck'), :);
% Ttax{:, 'Category'} = strrep(Ttax{:, 'Category'}, 'Paycheck', 'Tax');
% Ttax{:, 'Group'} = strrep(Ttax{:, 'Group'}, 'Salary', 'Tax');
% Tsalary{:, 'Amount'} = Tsalary{:, 'Amount'}*(1/(1-tax_rate))
% Ttax{:, 'Amount'} = Tsalary{:, 'Amount'}-Ttax{:, 'Amount'}

end