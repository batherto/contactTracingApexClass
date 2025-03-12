
//simulate a passes in list of person records we want to search for the cohabibtants of
set<Id> personIds = new set<Id>{'a26Kg0000010x7wIAA'};

//output the value of personIds to test
system.debug('--------- personIds to search for cohabitants ---------');
system.debug('personIds: ' + personIds);
system.debug('------------------------------------------------------');

List<String> healthStatuses = new List<string>{'Green','Yellow'};
// output the value of healthStatuses to testing
system.debug('--------- healthStatuses to search for cohabitants ---------');
system.debug('healthStatuses: ' + healthStatuses);
system.debug('------------------------------------------------------');

List<People_Tracing__c> peopleTraces = [SELECT person_1__c, person_2__c 
                                        FROM People_Tracing__c
                                        WHERE (person_1__c IN :personIds OR person_2__c IN :personIds)
                                        AND Contact_Type__c = 'Cohabitant'
                                        AND (person_1__r.Health_Status__c IN :healthStatuses OR person_2__r.Health_Status__c IN :healthStatuses)];

//output the value of peopleTraces to test
system.debug('--------- existing peopleTraces ---------');
system.debug('peopleTraces: ' + peopleTraces);
system.debug('-------------------------------------');

// create set to hold the ID's of the target cohabitants
set<Id> cohabitant = new set<Id>();



// loop over the peopleTraces we fetched 
for(People_Tracing__c pt : peopleTraces){
    if(!personIds.contains(pt.Person_1__c)) {
        cohabitant.add(pt.Person_1__c);
        }
   if(!personIds.contains(pt.Person_2__c)) {
        cohabitant.add(pt.Person_2__c);
        }
}
// output the cohabitant Ids
system.debug('--------- cobabitant Ids ---------');
system.debug('cohabitant: ' + cohabitant);
system.debug('-------------------------------------');
