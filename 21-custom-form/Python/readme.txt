Form recognisor:
    Module:pip install azure-ai-formrecognizer==3.0.0

    Setting up storgae account:
        1. On the Overview page for your resource group, note the Subscription ID and Location. You will need these values, along with your resource group name 
        2. az login --output none in terminal with Location as 21-custom-form folder
        3. az account list-locations -o table
        4. open setup.cmd and replace the necessary values
        
        Code Summary:
            1. Create a storage account in your Azure resource group
            2. Upload files from your local sampleforms folder to a container called sampleforms in the storage account
            3. Print a Shared Access Signature URI
            4. expiry_date for SAS URI expiry date 
        
    Train without labels:
        Code Summary:
            1. Namespaces from the package you installed are imported
            2. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated Client.
            3. The code uses the the training client to train a model using the images in your blob storage container, which is acessed using the SAS URI you generated.
            4. Training is performed with a parameter to indicate that training labels should not be used. Form Recognizer uses an unsupervised technique to extract the fields from the form images.
        
    Test without labels(Note model id from previous output):
        Code Summary:
            1. Namespaces from the package you installed are imported
            2. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated Client.
            3. The client is then used to extract form fields and values from the test1.jpg image.

    Train with Label:
        replace the code In the Main function, find the comment Train
        # Train model 
        poller = form_training_client.begin_training(trainingDataUrl, use_training_labels=True)
        model = poller.result()
    

    Test with label:
        Replace Model ID 


Documentatation: https://docs.microsoft.com/en-us/azure/cognitive-services/form-recognizer/