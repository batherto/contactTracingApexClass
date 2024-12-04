public with sharing class CTLocationTracingController {
    // information comment
    public Static List<Location_Tracing__c> getVisitors(String locationId) {
        //query Location_Tracing__c for records matching locationId sort by Visit Date in Descending order
        // return list of location_Tracing records

        List<Location_Tracing__c> locationTracingRecords = [SELECT Id, Person__c, Location__c, Visit_Date__c,Person__r.Token__c,Person__r.Health_Status__c
                                                            FROM Location_Tracing__c
                                                            WHERE Location__c = :locationId
                                                            WITH SECURITY_ENFORCED
                                                            ORDER BY Visit_Date__c DESC NULLS LAST];
        return locationTracingRecords;

    }

    public Static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
        //query locations_tracing records where person patches the personIds, get only 
        //records where visit date is withing the last 10 days and return the list

        List<Location_Tracing__c> locations = [SELECT Id,Person__c,Location__c
                                                FROM Location_Tracing__c
                                                WHERE Person__c IN :personIds
                                                AND 
                                                Visit_Date__c = LAST_N_DAYS:10
                                                WITH SECURITY_ENFORCED];
        return locations;
        
    }

    public Static List<Location_Tracing__c> getLocationsByLocationIds(set<Id> locationIds){
        // query location tracing records where location matched the locationIds and person health is green
        // only return the record where Visit Date is in the Last 10 days
        // return list of location tracing records
        List<Location_Tracing__c> locations = [SELECT Id, Person__c, Location__c, Visit_Date__c,Person__r.Token__c,Person__r.Health_Status__c
                                                FROM Location_Tracing__c
                                                WHERE Location__c IN :locationIds
                                                AND 
                                                Person__r.Health_Status__c = 'Green'
                                                AND 
                                                Visit_Date__c = LAST_N_DAYS:10
                                                WITH SECURITY_ENFORCED];
        return locations;
    }

    public Static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newlocationTraces){
       /*
        // isolate the ID's of the location tracing records
        Set<Id> inputRecIds = (new Map<Id,SObject>(locationTraces)).keySet();
        // query Location_Tracing object to get all records in the inputRecIds variable
        List<Location_Tracing__c> dupes = [SELECT Id, Person__c, Location__c, Visit_Date__c,Person__r.Token__c,Person__r.Health_Status__c
                                                FROM Location_Tracing__c
                                                WHERE Id IN :inputRecIds];
                                            
        return dupes;
        */
        // set to store unique location ID's
        Set<Id> locationIds = new Set<Id>();
        // set to store unique person ID's
        Set<Id> personIds = new Set<Id>();
        // loop over locationTraces records and populate the locationIds and personIds sets
        for(Location_Tracing__c trace : newlocationTraces){
            locationIds.add(trace.Location__c);
            personIds.add(trace.Person__c);
        }

        //map of location id, set of person id's
        // location1 : {person1, person2}
        // location2 : {person1, person3}
        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();
        // query records in location tracing object where location and person matches set of locationIds and personIds
        // return list of location tracing records
        List<Location_Tracing__c> existingRecords = [SELECT Id, Person__c, Location__c, Visit_Date__c,Person__r.Token__c,Person__r.Health_Status__c
                                                FROM Location_Tracing__c
                                                WHERE Location__c IN :locationIds
                                                AND 
                                                Person__c IN :personIds
                                                WITH SECURITY_ENFORCED];
        // list of blank duplicate records
        List<Location_Tracing__c> duplicates = new List<Location_Tracing__c>();
        // are there any records in dups?
        if(existingRecords != null && existingRecords.size() > 0){
            for (Location_Tracing__c trace : existingRecords){
                // if our map does not contain a key value for the location 
                if(! mapOfExistingRecords.containsKey(trace.Location__c)){
                    //create the location key in the map using the Put command which creates a new key-value pair (seperated by commas)
                    // in this case the Key is the Location and the Value is empty as indicated by new ser<Id>()
                    mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                }
                    // assume ocation exists so just add the person as a value to the existing location using add 
                    mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
                }

                //loop over new location tracing records
                for (Location_Tracing__c trace : newlocationTraces){
                    // check if the record in map contains location id and person id
                    if(mapOfExistingRecords.containsKey(trace.Location__c) && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c)){
                        duplicates.add(trace);
                    }
                }
            }
        return duplicates;


    }

}