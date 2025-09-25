
// null pointer exception
// try to act on an empty string
//String str;
//System.debug(str.toLowerCase());

//throw an excepeption programmatically 
//throw new NullPointerException();

System.debug('Before Exception');
try{
    Integer i = 10/0; // throws an exception
}
catch (Exception e) {
    // catchg exception here
    System.debug('Exception was thrown value of '+e.getMessage());
    System.debug('Exception type is :' +e.getTypeName());
}
finally{
    // optional finally block
}
System.debug('After Exception');