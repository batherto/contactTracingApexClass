
// can also write as 
// note nothing from the for loop is available anywhere else as the scope of the data is confined to the for loop
for (AggregateResult result: [SELECT StageName, 
                                    MAX(Amount) maxAmount, 
                                    MIN(Amount) minAmount ,
                                    AVG(Amount) averageAmount 
                                    FROM Opportunity 
                                    GROUP BY StageName] ){
    System.debug('Max amount for the '+ result.get('StageName')+' is '+result.get('maxAmount')+ ' Average amount is '+ result.get('averageAmount')+ ' Min amount is '+ result.get('minAmount')); 
}
