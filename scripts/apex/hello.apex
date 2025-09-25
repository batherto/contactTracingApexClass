// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

Plotter myPlotter = new Plotter(); 
myPlotter.plot(12, 26);

Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://api.coindesk.com/v1/bpi/currentprice.json');
request.setMethod('GET');
HttpResponse response = http.send(request);
// If the request was successful, parse the JSON response.
if (response.getStatusCode() == 200) {
    // Deserialize the JSON string into a Map<String, Object>
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    System.debug('CoinDesk API Response: ' + results);
    
    // You can access specific data, for example, the time updated
    Map<String, Object> timeMap = (Map<String, Object>) results.get('time');
    System.debug('Time Updated: ' + timeMap.get('updated'));
} else {
    System.debug('HTTP Request Failed with status code: ' + response.getStatusCode());
    System.debug('Response Body: ' + response.getBody());
}
