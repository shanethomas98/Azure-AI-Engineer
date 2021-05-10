Language Detection

Rest Client

Various namespaces are imported to enable HTTP communication
Code in the Main function retrieves the endpoint and key for your cognitive services resource - these will be used to send REST requests to the Text Analytics service.
The program accepts user input, and uses the GetLanguage function to call the Text Analytics language detection REST API for your cognitive services endpoint to detect the language of the text that was entered.
The request sent to the API consists of a JSON object containing the input data - in this case, a collection of document objects, each of which has an id and text.
The key for your service is included in the request header to authenticate your client application.
The response from the service is a JSON object, which the client application can parse.

SDK:
Using an SDK can greatly simplify development of applications that consume cognitive services.

pip install azure-ai-textanalytics==5.0.0

The namespace for the SDK you installed is imported
Code in the Main function retrieves the endpoint and key for your cognitive services resource - these will be used with the SDK to create a client for the Text Analytics service.
The GetLanguage function uses the SDK to create a client for the service, and then uses the client to detect the language of the text that was entered.

