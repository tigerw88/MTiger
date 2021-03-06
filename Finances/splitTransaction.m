function [T2, B] = splitTransaction( A, old_category, categories, amounts, type )
% SPLITTRANSACTION Splits a transaction into multiple categories
% This function could also be used to change a category name
%
% This is not a split function in the way that Mint's split feature works.
% This function is meant to take one classification of transactions and
% split all occurrences of them into other categories. For example, if your
% Mint register has monthly charges for rent, and you want to split each
% one of those into rent, utilities, and internet, you would use this
% function.
%
% INPUT
% + A - table that holds the transactions
% + old_category - the category that you want to split
% + categories - {n-by-1} list of desired categories (must include original
% category if you want it to still be included)
% + amounts - [n-by-1] list of amounts corresponding to each category
% + type - 'dollars' | 'percent' - replaces original amount as new dollar
% amount or percentage of existing dollar amount
%
% OUTPUT
% + B - table of only newly created transactions
% + T2 - table with all transactions (i.e., all transactions that were not
% involved in the split and B)
%
% HARD-CODED
%
%
%

%% parse input

    % check to make sure categories and amounts are equal in length
if ~(size(categories)==size(amounts)), error('Number of categories does not match number of amounts.'); end
% if numel(unique(findgroups(T.Category))) > 1, error('Not all categories are the same'); end;

switch type
    
    case 'dollars'
        
%         original_amount = 
%         if ~(original_amount==sum(amounts)), warning('Split amounts do not equal original amounts.'); end
        
    case 'percent'
        
%         percdiff = amounts-1;
%         if ~(sum(percdiff)==0), error('Split amounts do not equal 100%.'); end
        
    otherwise
        
        error('Type of split not understood. Use ''dollars'' or ''percent''.')
    
    
end

%%

    % Table Definitions:
% A - all original transactions 
% R - remaining transactions not involved in the split
% T - all transactions that will be split
% B - table of splits
% T2 - modified table with splits and previous transactions - i.e., [R; B]

%%

R = A; % intialize table of remaining transcations
R(strcmp(R.Category, old_category), :) = []; % remove transactions that will be split from the 'Remaining' table
T = A(strcmp(A.Category, old_category), :); % extract all transactions that are to be split
T{:, 'Category'} = strrep(T{:, 'Category'}, old_category, 'original_category');

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
T2 = [R; B];
T2 = sortrows(T2, 'Date', 'descend');



end