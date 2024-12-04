public with sharing class CTPeopleTracingController {
  //  opening comments
    public Static List<People_Tracing__c> getTraces(String recordID){
        //query people tracing records where metches recoprID
        return [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, Person_2__c, Person_2__r.Health_Status__c
                                         FROM People_Tracing__c 
                                         WHERE Person_1__c =:recordID 
                                         OR Person_2__c =:recordID 
                                         WITH SECURITY_ENFORCED
                                         ORDER BY Contact_Date__c DESC NULLS LAST];

    }

    public Static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){
                        
        // list to hold duplicate records
        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();
       
        Map<Id, Set<Id>> passedInRecordsMap = new Map<Id, Set<Id>>();
        // loop over records in the passed in records List
        for(People_Tracing__c ppl : newPeopleTraces){
            //insert into existingRecordsMap
           passedInRecordsMap.put(ppl.Id,new Set<Id>{ppl.Person_1__c,ppl.Person_2__c});
        }



        // now we would go fetch all the existing People_Tracing__c records

        List<People_Tracing__c> existingRecords = [SELECT Id, Name, Contact_Type__c, Person_1__c, Person_2__c
                                                    FROM People_Tracing__c
                                                    WITH SECURITY_ENFORCED];

        // check if there are no records being passed in to test
        if(existingRecords != null && existingRecords.size() > 0){
            System.Debug('There is Data in the SOQL query!');
            // loop over the existingRecords   
            for(People_Tracing__c existingRecord: existingRecords){
                // we need to compare it to each of the records in passedInRecordsMap
                // so lets loop over passedInRecordsMap
                for(Id existingRecordId : passedInRecordsMap.keySet()){
                    // this is the comparison
                    system.debug('The Key is: '+existingRecordId+' The values are: '+ passedInRecordsMap.get(existingRecordId));
                    // compare the people in the existing records to the people in the passed in. IF the passed in contains both people in one record then add that record to our dup list
                        if ((passedInRecordsMap.get(existingRecordId).contains(existingRecord.Person_1__c))&&(passedInRecordsMap.get(existingRecordId).contains(existingRecord.Person_2__c))){
                        system.debug('The value '+ existingRecord.Person_1__c+' exists!');
                        // push the record onto the duplicate list
                        duplicates.add(existingRecord);
                        }
                        else{
                        system.debug('The value '+ existingRecord.Person_1__c+' does NOT exist!');
                        }
                }
            }
        }      
        system.debug('There are: '+duplicates.size()+' duplicates!');
        system.debug('the duplicates are: '+ duplicates);
        return duplicates;
                                     
    }


}