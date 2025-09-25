// create a new account sobject instance
SObject accountRec = (SObject) Type.forName('Account').newInstance();
// set name
accountRec.put('Name','Sample SObject Account');
// set phone number
accountRec.put('Phone','5551234567');

// insert object
insert accountRec;