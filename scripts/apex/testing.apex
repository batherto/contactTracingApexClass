// test code here


// -------------example of Keyset ------------------
//Returns a set that contains all of the keys in the map.
Map<String, String> colorCodes = new Map<String, String>();

colorCodes.put('Red', 'FF0000');
colorCodes.put('Blue', '0000A0');

Set <String> colorSet = new Set<String>();
colorSet = colorCodes.keySet();
system.debug('-------------output------------------');
system.debug(colorSet);
system.debug('-------------------------------------');


//---------------end keyset example ----------------



List<Location_Tracing__c> testLocTracing = [SELECT Id,Name
                                     FROM Location_Tracing__c
                                     WITH SECURITY_ENFORCED];

Set<Id> idResult = (new Map<Id,SObject>(testLocTracing)).keySet();
system.debug('-------------output idResult ------------------');
system.debug(idResult);
system.debug('-------------------------------------');

// another query on Location_Tracing__c using the idResults set as the where clause
List<Location_Tracing__c> finalResults = [SELECT Id, Person__c, Location__c, Visit_Date__c,Person__r.Token__c,Person__r.Health_Status__c
                                            FROM Location_Tracing__c
                                            WHERE Id IN :idResult
                                            WITH SECURITY_ENFORCED];
                                            
system.debug('---------------finalResults-----------------------------');
system.debug(finalResults);





// here is a  map of just ID and then the value is all the data about the object

Map<Id,SObject> x = new Map<Id,SObject>(testlocTracing);
system.debug('-------------output the map ------------------');
system.debug(x);
system.debug('-------------------------------------');

// if we want we can just use the keyset function of thje map to output the keys
system.debug('-------------output the keyset of the map------------------');
system.debug(x.keySet());
system.debug('-------------------------------------');



/////set<Id> y = new Set<Id>(x).keySet();

Set<String> resultIds = (new Map<String,SObject>(testLocTracing)).keySet();


system.debug('-------------output------------------');
system.debug(resultIds);
system.debug('-------------------------------------');
List<Location_Tracing__c> existingRecords = [SELECT Id, Name
                                            FROM Location_Tracing__c
                                            WHERE Id  IN :resultIds
                                            WITH SECURITY_ENFORCED];

system.debug('-------------output------------------');
system.debug(existingRecords); 
system.debug('-------------------------------------');



///-------------------------------------------


// call the CTPersonController.cls and test getToken method

String token = CTPersonController.getToken('200-000-0000');
system.debug('------------Token---------------------');
system.debug(token);
system.debug('Testing the getHealthChanges method');
system.debug(CTPersonController.getRecentHealthChanges());


