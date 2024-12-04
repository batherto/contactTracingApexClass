public with sharing class CTPersonController {
    //opening comments
    public static String getToken(String mobileNum) {
        // generate a token which will be used to encrypt the mobile number
        // we are using the MD5 encryption algorithm and then encoding it to url safe
        Blob targetBlob = Blob.valueOf(mobileNum); 
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        String tokenString = EncodingUtil.base64Encode(hash);
        String result = tokenString.replace('+', '.').replace('/', '_');    
        return result;  
            
        /* public static String getToken(String mobileNum){
                Blob targetBlob = Blob.valueOf(mobileNum);
                Blob hash = Crypto.generateDigest('MD5', targetBlob);
                return hash.toString();
            */
        }
    public static List<Person__c> getRecentHealthChanges() {
        List<Person__c> persons = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
                                    FROM Person__c
                                    WITH SECURITY_ENFORCED
                                    ORDER BY Status_Update_Date__c DESC
                                    NULLS LAST
                                    LIMIT 100 ];
        return persons;
    }

    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm.trim();
        if(searchTerm == '' || searchTerm == null){
            return null;
        }
        searchTerm = searchTerm + '%';

        List<Person__c> persons = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
                                    FROM Person__c
                                    WHERE Name LIKE :searchTerm 
                                        OR Mobile__c LIKE :searchTerm
                                        OR Token__c LIKE :searchTerm
                                    WITH SECURITY_ENFORCED
                                    ORDER BY Status_Update_Date__c DESC] ;

        return persons;
    }
    public static Person__c getPersonById(String personId){
        List<Person__c> person = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
                                FROM Person__c
                                WHERE Id =:personId
                                WITH SECURITY_ENFORCED];
        if(person != null && person.size() > 0){
            return person[0];
        }else{
            return null;
        }
    }

    public static Map<String,Integer> getHealthStatusCount(){
        //create blank map of <String,Integter>
        Map<String,Integer> healthCount = new Map<String, Integer>();
        // create SOQL for loop to get information to pupulate Map
        for (AggregateResult result: [SELECT Health_Status__c, 
                                             COUNT(Id) numRecords 
                                             FROM Person__c 
                                             WITH SECURITY_ENFORCED
                                             GROUP BY Health_Status__c]){

            // put the values into the map
            HealthCount.put((String)(result.get('Health_Status__c')), (Integer)(result.get('numRecords')));
        }
        return healthCount;
    }
}