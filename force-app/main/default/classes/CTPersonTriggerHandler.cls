public with sharing class CTPersonTriggerHandler {
    public static void beforeInsertHandler() {
        system.debug('You are in the BeforeInsertHandler');

        // Make sure the field Health_Status__c is set to "Green" before insert
        for (Person__c person : (List<Person__c>)Trigger.new) {
            person.Health_Status__c = 'Green';
            // call the method to ceate a token from the mobilenumber and assign it to the token field.
            person.Token__c = CTPersonController.getToken(person.Mobile__c);

        }


    }
    public static void beforeUpdateHandler(){
        system.debug('you are in the beforeUpdateHandler');
        // create a variable to hold the old map
        Map<Id, Person__c> oldMap = (Map<Id, Person__c>)Trigger.oldMap;

        // update the status update date field to todays date
        for (Person__c person : (List<Person__c>)Trigger.new) {
            // update the Status_Update_Date__c field to todays date

            if (oldMap.get(person.Id).Health_Status__c != person.Health_Status__c) {
                person.Status_Update_Date__c = Date.today();
            }
        }
    }
}