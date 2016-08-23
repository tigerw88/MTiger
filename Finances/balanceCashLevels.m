cash_in_wallet = readCashInWalletFile; % n-by-2 matrix of [datenum, dollarAmount] pairs

%% Display Cash Level in Wallet:

display('Remaining Cash Level on:')    
for n = 1:size(cash_in_wallet,1)
    
    display(['     ' datestr(cash_in_wallet(n,1)) ' -> $' num2str(cash_in_wallet(n,2))])
    
end


% mint_cash_level;