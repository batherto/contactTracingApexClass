system.debug('------------- Begin Testing -----------');
// create 2 dummy records to simulate People_Tracing__c records passed in
ID smith = 'a26Kg0000010x7rIAA';
ID templeton = 'a26Kg0000010x7sIAA';

// second record id's
ID test = 'a26Kg0000010x7mIAA';
ID fred = 'a26Kg0000010x7wIAA';

// create new record of the People_Tracing__c
People_Tracing__c testRecord = new People_Tracing__c(
    Person_1__c = smith,
    Person_2__c = templeton,
    Contact_Type__c = 'Friends'
);

// create a seconde record of People_Trascing__c
People_Tracing__c test2 = new People_Tracing__c(
    Person_1__c = test,
    Person_2__c = fred,
    Contact_Type__c = 'Friends'
);

// create List to hold the People_Tracing__c records
// this simulates the Passing in of records to the Class
List<People_Tracing__c> passedInRecords = new List<People_Tracing__c>();
// testRecord to passedInRecords list
passedInRecords.add(testRecord);
// test2 to passedInRecords list
//passedInRecords.add(test2);

System.Debug('size of the passed in records list ='+passedInRecords.size());

// this will not work with fake records since the ID = null for them and when you push it onto
// a map the key has to be unique so the 2nd null will overright the 1st one
Map<Id, Set<Id>> passedInRecordsMap = new Map<Id, Set<Id>>();
// loop over records in the passed in records List
for(People_Tracing__c ppl : passedInRecords){
    //insert into existingRecordsMap
   passedInRecordsMap.put(ppl.Id,new Set<Id>{ppl.Person_1__c,ppl.Person_2__c});
}

System.Debug('size of the map created by the list passed in  ='+passedInRecordsMap.size());

// list to hold duplicate records
List<People_Tracing__c> duplicates = new List<People_Tracing__c>();


// now we would go fetch all the existing People_Tracing__c records

List<People_Tracing__c> existingRecords = [SELECT Id, Name, Contact_Type__c, Person_1__c, Person_2__c
                                            FROM People_Tracing__c
                                            WITH SECURITY_ENFORCED];

System.Debug('The map holds'+passedInRecordsMap);

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
    system.debug('There are: '+duplicates.size()+' duplicates!');
    system.debug('the duplicates are: '+ duplicates);
    

}