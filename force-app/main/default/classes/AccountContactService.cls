public with sharing class AccountContactService {
    public static void updateActiveContacts(Set<ID> accountIds) {
            system.debug('You are now in the Update Activities Contacts method of the Account Contact Service');
            // want to get the ID and count of how many contacts have the AccountID and Active
            List<AggregateResult> results = [
                SELECT AccountID, COUNT(Id) totalContacts 
                FROM CONTACT 
                WHERE Active__c = true AND AccountID IN :accountIds
                GROUP BY AccountId ];
            // output the results variable
            System.debug('Results = '+results);
            // create list of acconts we will update
            List<Account> accToUpdate = new List<Account>();
            //loop over the results
            for (AggregateResult result: results){
                // get accountId
                String resultAccountId = (String)result.get('AccountId');
                Integer totalContacts = (Integer)result.get('totalContacts');
                System.debug('resultAccountId = '+resultAccountId + ' totalContacts = '+totalContacts);
                //update the Total contacts on the Account Record
                Account acc = new Account(Id=resultAccountId, Total_Contacts__c=totalContacts);
                // add acc to the accToUpdate list
                accToUpdate.add(acc);
            }
                
            // and finally the update the list of accounts
            if (!Schema.sObjectType.Account.isUpdateable()){
                System.debug('Insufficient Permissions');
                }

            else{
                    update accToUpdate;
                }
    }
}