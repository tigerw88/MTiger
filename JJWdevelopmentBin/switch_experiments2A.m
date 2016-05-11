%{
The purpose of this experiment is to show that both switch statements and
else statements need a for loop wrapped around them if you want to test
multiple things
%}

digits = [1 2 3]

%%

for n = 1:length(digits)

switch digits(n)
    
    case 1
        
        disp('one')
        
    case 2
        
        disp('two')
        
    case 3
        
        disp('three')
        
    otherwise
   
        disp('finished')
        
end

end

%%

for n = 1:length(digits)

if digits(n)==1
    
    disp('one')
    
elseif digits(n)==2
    
    disp('two')
    
elseif digits(n)==3
    
    disp('three')
    
else
    
    disp('finished')
    
end

end