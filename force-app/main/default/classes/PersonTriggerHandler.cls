public with sharing class PersonTriggerHandler {
    public static void beforeInsertHandler() {
        // Make sure the field Health_Status__c is set to "Green" before insert
        for (Person__c person : (List<Person__c>)Trigger.new) {
            person.Health_Status__c = 'Green';
        }

    }
}