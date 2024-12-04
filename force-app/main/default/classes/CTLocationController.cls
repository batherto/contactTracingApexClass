public with sharing class CTLocationController {

    public static List<Location__c> getRecentStatusChanges() {
        List<Location__c> locations = [SELECT Id, Name, Status__c, Address__c, Status_Update_Date__c, Red_Score__c, Pincode__c
                                    FROM Location__c
                                    WITH SECURITY_ENFORCED
                                    ORDER BY Status_Update_Date__c DESC
                                    NULLS LAST
                                    LIMIT 100 ];
        return locations;
    }

    public static List<Location__c> searchLocations(String searchTerm){
        //query location__c returning all fields where searchTerm matchings either Name or Pincode
        searchTerm = searchTerm + '%';
        List<Location__c> locations = [SELECT Id, Name, Status__c, Address__c, Status_Update_Date__c, Red_Score__c, Pincode__c
                                        FROM Location__c
                                        WHERE Name LIKE :searchTerm OR Pincode__c LIKE :searchTerm
                                        WITH SECURITY_ENFORCED
                                        ORDER BY Status_Update_Date__c DESC NULLS LAST];
        return locations;
    }
    public static Location__c getLocationById(String locationId){
        //query location__c to return all redcords that match the search term
        // so initially we want a list
        List<Location__c> searchResults = [SELECT Id, Name, Status__c, Address__c, Status_Update_Date__c, Red_Score__c, Pincode__c
                                    FROM Location__c
                                    WHERE Id = :locationId
                                    WITH SECURITY_ENFORCED];
        //check if locations is not null and size is greater than 0
        if(searchResults != null && searchResults.size() > 0){
            return searchResults[0];
        }
        return null;
    }
    public static Map<string,Integer> getStatusCount(){
        //query the location tracing records and find the number of people visited for each status
        Map<string,Integer> mapOfHealthStatusCount = new Map<string,Integer>();
        for(AggregateResult ar : [SELECT Status__c, Count(Id) countOfStatus
                                    FROM Location__c
                                    WITH SECURITY_ENFORCED
                                    GROUP BY Status__c]){
            mapOfHealthStatusCount.put((String)ar.get('Status__c'), (Integer)ar.get('countOfStatus')); 
            }
        return mapOfHealthStatusCount;
    }
    
}