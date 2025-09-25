// Create a new Account with Name "WingNut Films" and Raiting of "Warm"
Account a1 = new Account(Name='WingNut Films', Rating='Warm');
System.System.debug('Newly creted Account = '+a1);
// insert the account by using DML
insert a1;
// Create a new Opportunity "Lord of the Rings" for account "WingNut Films" with Stage = Qualification and ClosedDate = Today
Opportunity o1 = new Opportunity(AccountId=a1.Id, Name='Lord of the Rings', StageName='Qualification', CloseDate=System.today());
System.System.debug('Newly creted Opportunity = '+o1);

// insert the o1 by using DML
insert o1;

//update account a1 Name to "New line Cinema"
a1.Name = 'New line Cinema';
System.System.debug('Updated Account = '+a1);
update a1;
o1.StageName = 'Closed=Won';
System.System.debug('updated Opportunity = '+o1);
update o1;

//now delete the o1  opportunity by using DML
delete o1;

//now undelete the o1 opportunity by using DML
undelete o1;
