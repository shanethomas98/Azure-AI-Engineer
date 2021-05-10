Congantive Security

Managing authentication keys through cli

    az login

    Tip: If you have multiple subscriptions, you'll need to ensure that you are working in the one that contains your cognitive services resource. Use this command to determine your current subscription - its unique ID is the id value in the JSON that gets returned.

        az account show
        If you need to change the subscription, run this command, changing <Your_Subscription_Id> to the correct subscription ID.

        az account set --subscription <Your_Subscription_Id>
        Alternatively, you can explicitly specify the subscription ID as a --subscription parameter in each Azure CLI command that follows.

    az cognitiveservices account keys list --name <resourceName> --resource-group <resourceGroup>
    <resourceName> with the name of your cognitive services resource, and <resourceGroup> with the name of the resource group in which you created it.

    Testing using cmd: curl -X POST "<yourEndpoint>/text/analytics/v3.0/languages?" -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <yourKey>" --data-ascii "{'documents':[{'id':1,'text':'hello'}]}"

    Regenerating a key:az cognitiveservices account keys regenerate --name <resourceName> --resource-group <resourceGroup> --key-name key1

    Tip: In this exercise, you used the full names of Azure CLI parameters, such as --resource-group. You can also use shorter alternatives, such as -g, to make your commands less verbose (but a little harder to understand). The Cognitive Services CLI command reference lists the parameter options for each cognitive services CLI command.


Securing Access using key vault

    One option is to store the key in an environment variable or a configuration file where the application is deployed, but this approach leaves the key vulnerable to unauthorized access. A better approach when developing applications on Azure is to store the key securely in Azure Key Vault, and provide access to the key through a managed identity (in other words, a user account used by the application itself).

    Creating a service principal:
        To access the secret in the key vault, your application must use a service principal that has access to the secret.

        az ad sp create-for-rbac -n "https://<spName>" --role owner --scopes subscriptions/<subscriptionId>/resourceGroups/<resourceGroup>
        Replacing <spName> with a suitable name for an application identity (for example, ai-app). Also replace <subscriptionId> and <resourceGroup> with the correct values for your subscription ID and the resource group containing your cognitive services and key vault resources
        
        Tip: If you are unsure of your subscription ID, use the az account show command to retrieve your subscription information - the subscription ID is the id attribute in the output.

        Output:
        ```
        {
            "appId": "abcd12345efghi67890jklmn",
            "displayName": "ai-app",
            "name": "https://ai-app",
            "password": "1a2b3c4d5e6f7g8h9i0j",
            "tenant": "1234abcd5678fghi90jklm"
        }
        ```

        az keyvault set-policy -n <keyVaultName> --spn "https://<spName>" --secret-permissions get list
        replacing <keyVaultName> with the name of your Azure Key Vault resource and <spName> with the same value you provided when creating the service principal.


Using service principal in an application:

    Note: In this exercise, we'll store the service principal credentials in the application configuration and use them to authenticate a ClientSecretCredential identity in your application code. This is fine for development and testing, but in a real production application, an administrator would assign a managed identity to the application so that it uses the service principal identity to access resources, without caching or storing the password.

    pip install azure-ai-textanalytics==5.0.0
    pip install azure-identity==1.5.0
    pip install azure-keyvault-secrets==4.2.0

    Configuration in keyvault:

        The endpoint for your Cognitive Services resource

        The name of your Azure Key Vault resource

        The tenant for your service principal

        The appId for your service principal

        The password for your service principal
        
    Code Summary:

        The namespace for the SDK you installed is imported
        Code in the Main function retrieves the application configuration settings, and then it uses the service principal credentials to get the cognitive services key from the key vault.
        The GetLanguage function uses the SDK to create a client for the service, and then uses the client to detect the language of the text that was entered.


Deploy and run a Text Analytics container
    Many commonly used cognitive services APIs are available in container images. For a full list, check out the cognitive services documentation. In this exercise, you'll use the container image for the Text Analytics language detection API; but the principles are the same for all of the available images.

    In the Azure portal, on the Home page, select the ＋Create a resource button, search for container instances, and create a Container Instances resource with the following settings:

    Basics:

        Subscription: Your Azure subscription
        Resource group: Choose the resource group containing your cognitive services resource
        Container name: Enter a unique name
        Region: Choose any available region
        Image source: Docker Hub or other Registry
        Image type: Public
        Image: mcr.microsoft.com/azure-cognitive-services/textanalytics/language:1.1.012840001-amd64
        OS type: Linux
        Size: 1 vcpu, 4 GB memory
    
    Networking:

        Networking type: Public
        DNS name label: Enter a unique name for the container endpoint
        Ports: Change the TCP port from 80 to 5000

    Advanced:

        Restart policy: On failure

        Environment variables:

        Mark as secure	Key	Value
        Yes	ApiKey	Either key for your cognitive services resource
        Yes	Billing	The endpoint URI for your cognitive services resource
        No	Eula	accept
        Command override: [ ]

    Tags:

        Don't add any tags

    Wait for deployment to complete, and then go to the deployed resource.

    Observe the following properties of your container instance resource on its Overview page:

        Status: This should be Running.
        IP Address: This is the public IP address you can use to access your container instances.
        FQDN: This is the fully-qualified domain name of the container instances resource, you can use this to access the container instances instead of the IP address.
        
        Note: In this exercise, you've deployed the cognitive services container image for text translation to an Azure Container Instances (ACI) resource. You can use a similar approach to deploy it to a Docker host on your own computer or network by running the following command (on a single line) to deploy the language detection container to your local Docker instance, replacing <yourEndpoint> and <yourKey> with your endpoint URI and either of the keys for your cognitive services resource.
        docker run --rm -it -p 5000:5000 --memory 4g --cpus 1 mcr.microsoft.com/azure-cognitive-services/textanalytics/language Eula=accept Billing=<yourEndpoint> ApiKey=<yourKey>
        The command will look for the image on your local machine, and if it doesn't find it there it will pull it from the mcr.microsoft.com image registry and deploy it to your Docker instance. When deployment is complete, the container will start and listen for incoming requests on port 5000.

Use the container
    In Visual Studio Code, in the 04-containers folder, open rest-test.cmd and edit the curl command it contains (shown below), replacing <your_ACI_IP_address_or_FQDN> with the IP address or FQDN for your container.

    curl -X POST "http://<your_ACI_IP_address_or_FQDN>:5000/text/analytics/v3.0/languages?" -H "Content-Type: application/json" --data-ascii "{'documents':[{'id':1,'text':'Hello world.'},{'id':2,'text':'Salut tout le monde.'}]}"
    Save your changes to the script. Note that you do not need to specify the cognitive services endpoint or key - the request is processed by the containerized service. The container in turn communicates periodically with the service in Azure to report usage for billing, but does not send request data.

    Right-click the 04-containers folder and open an integrated terminal. Then enter the following command to run the script:

    rest-test
    Verify that the command returns a JSON document containing information about the language detected in the two input documents (which should be English and French).