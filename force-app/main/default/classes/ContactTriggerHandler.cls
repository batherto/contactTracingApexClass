public with sharing class ContactTriggerHandler {
    public static void afterInsertHandler() {
        // create list of acconts we will update
        system.debug('Welcome to the after Insert Handler!');
        Set<Id> accountIds = new Set<Id>();
        // loop over trigger.net and place ID into the4 AccIds set
        // with the new Handler we will typecast the trigger.new  since we are in a sub-function 
        // trigger.new outputs a list of SObjects so need to cast to what we want (contact)

        for(Contact con : (List<Contact>)Trigger.new) {
            if (String.isNotBlank(con.AccountId)){
                    accountIds.add(con.AccountId);
            }

        }
        AccountContactService.updateActiveContacts(accountIds);

    }
    public static void afterUpdateHandler(){

        system.debug('Welcome to the after Update Handler!');
            Set<Id> accountIds = new Set<Id>();
            // assign the OldMap to a variable 
            Map<Id, Contact> oldMap = (Map<Id, Contact>)Trigger.oldMap;
            // loop over trigger.net and place ID into the accounts SET so we can iterate over and update each
            for(Contact con : (List<Contact>)Trigger.new) {
                // here we well not only check if the account field is empty but if the acive field is not the same as 
                // the previous account__c value
                // Trigger.OldMap.get(con.Id) will fetch the values for the Current ID key
                if (String.isNotBlank(con.AccountId) && oldMap.get(con.Id).Active__c != con.Active__c) {
                    accountIds.add(con.AccountId);
                    system.debug('in the loop only when active status changed');
                }
                else if (oldMap.get(con.Id).AccountId != con.AccountId){
                    // we want to add to the SET the current Account as well as the old account to update its number
                    accountIds.add(con.AccountId);
                    accountIds.add(oldMap.get(con.Id).AccountId);
                    system.debug('in the loop for account changed');
                }

            }
            // output the accountIds list
            System.debug('accountIds = '+accountIds);
            AccountContactService.updateActiveContacts(accountIds);
    }
    public static void afterDeleteHandler(){
        system.debug('Welcome to the after Delete Handler!');
            // create list of acconts we will update
            Set<Id> accountIds = new Set<Id>();
            for(Contact con : (List<Contact>)Trigger.old) {
                if (String.isNotBlank(con.AccountId)){
                        accountIds.add(con.AccountId);
                }
    
            }
            AccountContactService.updateActiveContacts(accountIds);


    }
    public static void afterUndeleteHandler(){
        system.debug('Welcome to the after IUndelet Handler!');
                    // create list of acconts we will update
                    Set<Id> accountIds = new Set<Id>();
                    for(Contact con : (List<Contact>)Trigger.new) {
                        if (String.isNotBlank(con.AccountId)){
                                accountIds.add(con.AccountId);
                        }
            
                    }
                    AccountContactService.updateActiveContacts(accountIds);
    }
}