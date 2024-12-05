public with sharing class AccountContactService {
    public static void updateActiveContacts(Set<ID> accountIds) {
            system.debug('You are now in the Update Activities Contacts method of the Account Contact Service');
            // want to get the ID and count of how many contacts have the AccountID and Active
            // UPDATE --there was an issue here where the fact that a contact gets changed to 'innactive' 
            // which triggers the trigger. However the SOQL statement below will not find any accounts
            // that need updateing since the change from active to innactive has already hapened
            List<AggregateResult> results = [
                SELECT AccountID, COUNT(Id) totalContacts 
                FROM CONTACT 
                WHERE Active__c = true AND AccountID IN :accountIds
                GROUP BY AccountId ];
            // output the results variable
            System.debug('Results = '+results);
            // create list of accounts we will update
            // initially this was just a list but will update to a map of ID and ACCOUNT
            Map<Id,Account> accToUpdate = new Map<Id, Account>();
            //loop over the results
            for (AggregateResult result: results){
                // get accountId
                String accId = (String)result.get('AccountId');
                Integer totalContacts = (Integer)result.get('totalContacts');
                System.debug('resultAccountId = '+accId + ' totalContacts = '+totalContacts);
                //update the Total contacts on the Account Record
                Account acc = new Account(Id=accId, Total_Contacts__c=totalContacts);
                // add acc to the accToUpdate list which is now a map (see update abovce)
                accToUpdate.put(accId,acc);
            }
            // updated accounts with zero active contacts
            // iterate over accountIds
            for(Id accId : accountIds){
                // if no contacts are found then the accounts total contacts should be zero
                if(!accToUpdate.containsKey(accId)){
                    //if missing the accID create a new account and set to zero
                    accToUpdate.put(accId, new Account(Id=accId, Total_Contacts__c=0));
                }
            }

                
            // and finally the update the Accounts using the map accToUpdate
            update accToUpdate.values();
        }

}