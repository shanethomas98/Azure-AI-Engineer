Image CLassification: (Custom vision)

    Resourse Used: Custom vision

    Creating Custom Vision Project:

    Training a model:
        1.https://customvision.ai
        2. Create a new Project:
            Name: Classify Fruit
            Description: Image classification for fruit
            Resource: The Custom Vision resource you created previously
            Project Types: Classification
            Classification Types: Multiclass (single tag per image)
            Domains: Food
        3. Click + button to add images. adn upload Images and write a tag for them.
        4. Click the Train buttom(Looks like setting) and click quick or advanced Training
        5. Note: The performance metrics are based on a probability threshold of 50% for each prediction (in other words, if the model calculates a 50% or higher probability that an image is of a particular class, then that class is predicted). You can adjust this at the top-left of the page.


    Testing a model:
        1. Click Quick Test(Tick nect to train icon(settings Icon))
        2. Upload the image

    Training using code:

        1. Getting the keys:
            Click Settings icon on next to trianing and test icon. Under General we can find the project ID and under resources we can fins endpoint and the key.
        2. code summary:
                1. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated CustomVisionTrainingClient, which is then used with the project ID to create a Project reference to your project.
                2. The Upload_Images function retrieves the tags that are defined in the Custom Vision project and then uploads image files from correspondingly named folders to the project, assigning the appropriate tag ID.
                3. The Train_Model function creates a new training iteration for the project and waits for training to complete.


    Publishing the Model:

    Getting the keys:
        1. In the performance page, click the tick icon(Publish in the top left corner)
        2. Provide the Model Name and Prediction Resource
        3. On the top left next to custom vision, find the Eye with gear icon. It will take you to cutom vison homepage.
        4. At the Home page near the top right click on settings to view settings Custom Vision. Under Resources, go to Prediction resource and get Key and Endpoint values.
    Code summary(test classifier):

        1. Namespaces from the package you installed are imported
        2. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated CustomVisionPredictionClient.
        3. The prediction client object is used to predict a class for each image in the test-images folder, specifying the project ID and model name for each request. Each prediction includes a probability for each possible class, and only predicted tags with a probability greater than 50% are displayed.
        
    Documentation: https://docs.microsoft.com/en-us/azure/cognitive-services/custom-vision-service/

Object Detection:

    Setup:
        1. https://customvision.ai
        2. Create a new project:
            Name: Detect Fruit
            Description: Object detection for fruit.
            Resource: The Custom Vision resource you created previously
            Project Types: Object Detection
            Domains: General
        3. Click plus symbol on top left cornor to add images.
        4. Upload the images and tag them.
    
    Getting the keys:
        1. In the performance page, click the tick icon(Publish in the top left corner)
        2. Provide the Model Name and Prediction Resource
        3. On the top left next to custom vision, find the Eye with gear icon. It will take you to cutom vison homepage.
        4. At the Home page near the top right click on settings to view settings Custom Vision. Under Resources, go to Prediction resource and get Key and Endpoint values.

    Modules needed:
        pip install azure-cognitiveservices-vision-customvision==3.1.0
    
    Steps to upload file using code:
        1. Update the .env file for train-detector 
        2. Code Summary:
            a. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated CustomVisionTrainingClient, which is then used with the project ID to create a Project reference to your project.
            b. The Upload_Images function extracts the tagged region information from the JSON file and uses it to create a batch of images with regions, which it then uploads to the project.
        
    Train and test:
        1. Click train button(greenbutton with 2 gears) and click quick training.
        2. Click Quick test.
    
    Publish and Test:
    
        1. In Custom Vision Portal, Performance and click Publish.
        2. Settings:
            - Model name: fruit-detector
            - Prediction Resource: The prediction resource
        3. At the top left of the Project Setting Page, click the eye with gear symbol to go to home page.
        4. Fo to setting icon. Under Resources, go to prediction, find the key and endpoin values

    Using classifier using code:
        Code Summary:

        1. The Main function retrieves the configuration settings, and uses the key and endpoint to create an authenticated CustomVisionPredictionClient.
        2. The prediction client object is used to get object detection predictions for the produce.jpg image, specifying the project ID and model name in the request. The predicted tagged regions are then drawn on the image, and the result is saved as output.jpg.

        Documentation: https://docs.microsoft.com/en-us/azure/cognitive-services/custom-vision-service/