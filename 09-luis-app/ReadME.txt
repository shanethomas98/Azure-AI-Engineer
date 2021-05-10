Create a Luis App

Note: The task of the language understanding app is to predict the user's intent, and identify any entities to which the intent applies. It is not its job to actually perform the actions required to satisfy the intent. For example, the clock application can use a language app to discern that the user wants to know the time in London; but the client application itself must then implement the logic to determine the correct time and present it to the user.

Create a new Language Understanding, not Language Understanding (Azure Cognitive Services)
Create option: Both
Subscription: Your Azure subscription
Resource group: Choose or create a resource group (if you are using a restricted subscription, you may not have permission to create a new resource group - use the one provided)
Name: Enter a unique name
Authoring location: Select your preferred location
Authoring pricing tier: F0
Prediction location: The same as your authoring location
Prediction pricing tier: F0

Luis app tutorial:
1.Go to https://www.luis.ai
2.Go to Intents and Create eg. GetTime
3. Add feature like (eg. what time is it?)
4. In None Intent fill feature that you dont need like hi, hello, goodbye

Training and testing app:
Testing can be of two types 1. single and batch. It can be toggled using the option in test popup.
For batch testing a JSON file is needed just like the batch-test.json file in the folder.

For single test:
1. Click Train to train the model.
2.Click Test to test the model. eg. tell me the time and see if you get the desired intent.

For batch:
1.Upload file by using Import and name it
2. Click see results to see the output, yu will get a confusion matrix
Note: Each utterance is scored as positive or negative for each intent - so for example "what time is it?" should be scored as positive for the GetTime intent, and negative for the GetDate intent. The points on the confusion matrix show which utterances were predicted correctly (true) and incorrectly (false) as positive and negative for the selected intent.
3.You can click the dots to check the input values and the output.Each intent is separated so click the appropriate intent for checking.
4. The intent that have high number of false positives and false negatives needs more sample and retraining.


Adding entities:

entities like Ml based entities, List of entities and regex can be used to capture entities.
Steps:
1. Go to Entities below Intent, click create.
2. Name the entity and select the type of Entity. For regex add the the regex statement.
3. After an entity is created go to intents and add an utterance of feature eg.what time is it in London?
4. Once the utterance is added select higlight the entity by clicking and select the relevent option from the dropdwon list.
5. For List, Normalized Values and synonyms has to to be added after step2, eg. sunday sun


Publishing the app

1. At the top right of the Language Understanding portal, select Publish.

2. Select Production slot, and publish the app.

3.After publishing is complete, at the top of the Language Understanding portal, select Manage.

4. On the Settings page, note the App ID. Client applications need this to use your app.

5. On the Azure Resources page, note the Primary Key, Secondary Key, and Endpoint URL
6. Use this to run cmd files in 09-luis-app. the cmd can be run using such commands:GetIntent "What's the time?"

Active learning.

1. After testing the app in cmd. In the Language Understanding portal, Select Build and view the Review endpoint utterances page. This page lists logged utterances that the service has flagged for review.
2. For any utterances for which the intent and a new location entity (that wasn't included in the original training utterances) are correctly predicted, select ✓ to confirm the entity, and then use the ⤒ icon to add the utterance to the intent as a training example.
3. Find an example of an utterance in which the GetTime intent was correctly identified, but a Location entity was not identified; and select the location name and map it to the location entity. Then use the ⤒ icon to add the utterance to the intent as a training example.
4. Go to the Intents page and open the GetTime intent to confirm that the suggested utterances have been added.
5. At the top of the Language Understanding portal, select Train to retrain the app.
At the top right of the Language Understanding portal, select Publish and republish the app to the Production slot.

Exporting the app:

You can use the Language Understanding portal to develop and test your language app, but in a software development process for DevOps, you should maintain a source controlled definition of the app that can be included in continuous integration and delivery (CI/CD) pipelines. While you can use the Language Understanding SDK or REST API in code scripts to create and train the app, a simpler way is to use the portal to create the app, and export it as a .lu file that can be imported and retrained in another Language Understanding instance. This approach enables you to make use of the productivity benefits of the portal while maintaining portability and reproducibility for the app.

1.In the Language Understanding portal, select Manage.
2.On the Versions page, select the current version of the app (there should only be one).
3.In the Export drop-down list, select Export as LU. Then, when prompted by your browser, save the file in the 09-luis-app folder.
4.In Visual Studio Code, open the .lu file you just exported and downloaded (if you are prompted to search the marketplace for an extension that can read it, dismiss the prompt). Note that the LU format is human-readable, making it an effective way to document the definition of your Language Understanding app in a team development environment.

Documentation:
https://docs.microsoft.com/en-us/azure/cognitive-services/luis/