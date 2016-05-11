function result = whatDoesThisDo( int )

global test_var2

test_var1 = int;
% test_var2 = int;
result = doThisAlso();

    function result = doThisAlso()
        
       result = test_var2*2;
        
    end

end