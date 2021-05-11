Create a  bot:

    Requires Bot Emulator
    Packages:
        pip install botbuilder-core
        pip install asyncio
        pip install aiohttp
        pip install cookiecutter==1.7.0

    Code source:
        cookiecutter https://github.com/microsoft/botbuilder-python/releases/download/Templates/echo.zip
        When prompted:
            bot_name: TimeBot
            bot_description: A bot for our times
        cd TimeBot
        dir
    

    Testing in Bot Framework Emulator:
        1.Run python app.py for intializing the app.
        2.Start Bot framework Emulator -> open bot ->http://localhost:3978/api/messages
        3.After the app start and wait for the app to send Hello and welcome!
        4.The bot echos back whatever we enter.
    
    Modify the bot code:
        1.You've created a bot that echoes the user's input back to them. It's not particularly useful, but serves to illustrate the basic flow of a conversational dialog. A conversation with a bot consists of a sequence of activities, in which text, graphics, or user interface cards are used to exchange information. The bot begins the conversation with a greeting, which is the result of a conversation update activity that is triggered when a user initializes a chat session with the bot. Then the conversation consists of a sequence of further activities in which the user and bot take it in turns to send messages.
        2.Navigate to TimeBot/bot.py
        3.Note:The code in this file consists of activity handler functions; one for the Member Added conversation update activity (when someone joins the chat session) and another for the Message activity (when a message is received). The conversation is based on the concept of turns, in which each turn represents an interaction in which the bot receives, processes, and responds to an activity. The turn context is used to track information about the activity being processed in the current turn.
        4. add the following code:
            from datetime import datetime
            async def on_message_activity(self, turn_context: TurnContext):
                input_message = turn_context.activity.text
                response_message = 'Ask me what the time is.'
                if (input_message.lower().startswith('what') and 'time' in input_message.lower()):
                    now = datetime.now()
                    response_message = 'The time is {}:{:02d}.'.format(now.hour,now.minute)
                await turn_context.send_activity(response_message)
        5.python app.py
        6. Test the code in Bot Framework like before. The bot now responds to the query "What is the time?" by displaying the local time where the bot is running. For any other query, it prompts the user to ask it what the time is. This is a very limited bot, which could be improved through integration with the Language Understanding service and additional custom code, but it serves as a working example of how you can build a solution with the Bot Framework SDK by extending a bot created from a template.
    

    Create an Azure application registration:
        1. In TimeBot folder:
            az login
            If you have multiple accounts:
            az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
        2. Parameters: TimeBot(displayname)  Super$ecretPassw0rd(password)
            Command:az ad app create --display-name "TimeBot" --password "Super$ecretPassw0rd" --available-to-other-tenants
    
    Create Azure resources:
        1. In TimeBot folder:
            Parameters: - YOUR_RESOURCE_GROUP: The name of your existing resource group.
                        - YOUR_APP_ID: The appId value you noted in the previous procedure.
                        - REGION: An Azure region code (such as eastus).
                        -All other placeholders: Unique values that will be used to name the new resources. The resource IDs you specify must be globally unique strings netween 4 and 42 characters long. Make a note of the value you use for the BotId and newWebAppName parameters - you will need them later.
            Command: az deployment group create --resource-group "YOUR_RESOURCE_GROUP" --template-file "deploymenttemplates/template-with-preexisting-rg.json" --parameters appId="YOUR_APP_ID" appSecret="Super$ecretPassw0rd" botId="A_UNIQUE_BOT_ID" newWebAppName="A_UNIQUE_WEB_APP_NAME" newAppServicePlanName="A_UNIQUE_PLAN_NAME" appServicePlanLocation="REGION" --name "A_UNIQUE_SERVICE_NAME"

    Prepare bot for deployment:
        1. In TimeBot folder:
            rmdir /S /Q  __pycache__
            notepad requirements.txt
        2. Do these changes in requiremnets.txt:
            botbuilder-core==4.11.0
            aiohttp
        3. Put all the files in TimeBot into zip folder with the same name.

    Deploy and testing the bot:
        1. In the folder where TimeBot.zip exists:
        Parameters:
            - YOUR_RESOURCE_GROUP: The name of your existing resource group.
            - YOUR_WEB_APP_NAME: The unique name you specified for the newWebAppName parameter when creating Azure resources
        Command: az webapp deployment source config-zip --resource-group "YOUR_RESOURCE_GROUP" --name "YOUR_WEB_APP_NAME" --src "TimeBot.zip"

        2. In the Azure portal, in the resource group containing your resources, open the Bot Channels Registration resource (which will have the name you assigned to the BotId parameter when creating Azure resources).
        3. In the Bot management section, select Test in Web Chat. Then wait for your bot to initialize.
        4. Enter a message such as Hello and view the response from the bot, which should be Ask me what the time is.
        5. Enter What is the time? and view the response.

    Use the Web Chat channel in a web page:

        One of the key benefits of the Azure Bot Service is the ability to deliver your bot through multiple channels.

        Steps:
            1. In the Azure portal, on the blade for your Bot, view the Channels your bot is connected to.
            2. Note that the Web Chat channel has been added automatically, and that other channels for common communication platforms are available.
            3. Next to the Web Chat channel, click Edit. This opens a page with the settings you need to embed your bot in a web page. To embed your bot, you need the HTML embed code provided as well as one of the secret keys generated for your bot.
            4. Copy the Embed code.
            5. In Visual Studio Code, expand the 13-bot-framework/web-client folder and select the default.html file it contains.
            6. In the HTML code, paste the embed code you copied directly beneath the comment add the iframe for the bot here
            7. Back in the Azure portal, select Show for one of your secret keys (it doesn't matter which one), and copy it. Then return to Visual Studio Code and paste it in the HTML embed code you added previously, replacing YOUR_SECRET_HERE.
            8. In Visual Studio Code, in the Explorer pane, right-click default.html and select Reveal in File Explorer.
            9. In the File Explorer window, open default.html in Microsoft Edge.
            10. In the web page that opens, test the bot by entering Hello. Note that it won't initialize until you submit a message, so the greeting message will be followed immediately by a prompt to ask what the time is.
            11. Test the bot by submitting What is the time?.


Documentation: https://docs.microsoft.com/en-us/azure/bot-service/index-bf-sdk?view=azure-bot-service-4.0


Creating Bot Framework Composer:
    Documentation and tutorial: https://docs.microsoft.com/en-us/composer/tutorial/tutorial-create-bot

QnA Maker:
    Documentation and tutorial: https://docs.microsoft.com/en-us/azure/cognitive-services/qnamaker/