public with sharing class AccountController3Map {

    public static void updateAvgCaseResolutionDays(List<Id> accountId){
        System.debug('you are in the Map Version updateAvgCaseResolutionDays function');
        System.debug('we got the following as accountId = '+accountId);
        // create the two maps we are going to use
        Map<Id,Integer> accountTotalCaseMap = new Map<Id,Integer>();
        Map<Id,Integer> accountTotalCaseDaysMap = new Map<Id,Integer>();
        // retrieve all the cases for the accounts in the list
        for (Case caseObj : [SELECT Id, CreatedDate, ClosedDate, AccountId
                                FROM Case
                                WHERE IsClosed=true
                                AND AccountId IN :accountId]){
            // check if the case for this account is already in the maps, if not add it
            system.debug('I am in the loop and AccountID = '+caseObj.AccountId);
            // if the map does not already have the key (containskey) then add it
            // key idea is that this only executes IF the account is not in the map
            if (!accountTotalCaseMap.containsKey(caseObj.AccountId)){
                accountTotalCaseMap.put(caseObj.AccountId,0);
                accountTotalCaseDaysMap.put(caseObj.AccountId,0);
            }
            // increment the values in the map for this specific account id
            // so this says for THIS current Account ID get its current value from the map  
            Integer totalCases = accountTotalCaseMap.get(caseObj.AccountId);
            // now add one to the value that the current account ID has in the mpa
            totalCases++;
            // now we will update  this value of totalCases which is the old value +1 in the map for this accounID
            accountTotalCaseMap.put(caseObj.AccountId,totalCases);
            
            // now we want to do the same thing for the value of totaldays. this will use the same idea
            // where we get the current value for the total days for our current account id. we then 
            // add to it whtever the current cases's days value is and then update the map with the new value
            Integer totalDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
            // add the two values together
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
            // now we put this value into the map for this account id
            accountTotalCaseDaysMap.put(caseObj.AccountId,totalDays);
            

    }
    // lets output the  lists to test their contents
    system.debug('accountTotalCaseMap = '+accountTotalCaseMap);
    system.debug('accountTotalCaseDaysMap = '+accountTotalCaseDaysMap);
    // loop over the maps and update the values
        }
}