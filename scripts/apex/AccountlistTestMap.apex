system.debug('------------- Begin Testing -----------');
List<Account> accountsIDs = [SELECT Id FROM Account LIMIT 4];
List<Id> iDlist = new List<Id>();
System.debug('List of Accounts = '+accountsIDs);
// loop over accountsIDs and place the ID's into iDlist
for(Account a :accountsIDs){
    iDlist.add(a.Id);
}
System.debug('List of IDs to send to class = '+iDlist);
AccountController3Map.updateAvgCaseResolutionDays(iDlist);
