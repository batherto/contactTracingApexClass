public with sharing class AccountController2 {

    public static void updateAvgCaseResolutionDays(List<Id> accountId){
        System.debug('you are in the updateAvgCaseResolutionDays function');
        System.debug('we got the following as accountId = '+accountId);
        // Retrieve all the cases for this account')
        Integer totalDays = 0;
        Integer totalCases = 0;
        // need a list of cases variable we will put the cases we want to update at the end
        List<Case> casesToUpdate = new List<Case>();
        // retrive all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        list <Case> cases = [SELECT Id, CreatedDate, ClosedDate,accountId
                             FROM Case
                             WHERE IsClosed=true
                             AND AccountId IN :accountId];
        System.debug(cases);

        // lets loop over the accountID's 
        for (Id accId : accountId){
            // clear the totalDays and totalCases for each account
            // as we iterate through the accountId's
            system.debug('Outer loop Account ID = '+accId);
            totalDays = 0;
            // loop over all the cases
            for (Case caseObj : cases){
                //initialize totalCases  to zero at start of loop
                // check if the accountId from the accId's matches the case's accountId and then add the days between them
                if (caseObj.accountId==accId){
                    system.debug('Account ID = '+accId+' and Case ID = '+caseObj.Id);
                    // calculate duration in days
                    totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
                    caseObj.Days_Open__c = totalDays;
                    System.debug('Total Days the case was open = '+totalDays);
                    totalCases++;  
                    // add this case to our casestoupdate list
                    casesToUpdate.add(caseObj);              
                } 
            }
            System.debug('Total Number of Cases = '+totalCases);
        }
        system.debug('We are out of the loop and have our final case list we will update');
        system.debug('here is the list  '+casesToUpdate);
        // now we want to loop over the casesToUpdate list and update the account object with the avg resolution time)
        /*
        for (Case caseObj : cases){
            // increase number of cases
            totalCases++;
            // get duration in days and add it to totalDays
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
        }
        Decimal resolutionDays = totalDays/totalCases;
        // update account object
        Account acc = new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays);
        update acc;
        */
    }
}