List<String> myList = new List<String>(); // Define a new list
// can also use tradtional arrat notation
// String[] myList = new List<String>();
System.debug('List looks like - '+mylist);
myList.add('Red');                    // Adds a second element of value 47 to the end 
                                       // of the list
System.debug('after addomg Red looks like - '+mylist);
System.debug('Get the Element at the 0 position - '+mylist[0]);
// output the index of the value Red using the method indexOf
System.debug('Get the index of the value Red - '+mylist.indexOf('Red'));
System.debug('Value when IndexOf cant find the value such as value of green - '+mylist.indexOf('green'));
////Integer i = myList.get(0);                   // Retrieves the element at index 0
//myList.set(0, 1);                           // Adds the integer 1 to the list at index 0
//myList.clear();                    // Removes all elements from the list