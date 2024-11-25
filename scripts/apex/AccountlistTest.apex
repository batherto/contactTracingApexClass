List<Account> accs = [SELECT Id,Name FROM Account LIMIT 2];
System.debug('List of Accounts = '+accs);
List<Contact> targetCon = [SELECT ID,Name FROM Contact WHERE AccountId IN :accs];
System.Debug('List of targets ='+targetCon);
