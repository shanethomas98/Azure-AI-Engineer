Text analytics

    In the Main function, note that code to load the cognitive services key and region from the configuration file has already been provided

    Detect Language:

        In the GetLanguage function, under the comment Use the Translator detect function, add the following code to use the Translator's REST API to detect the language of the specified text

        # Use the Translator detect function
        path = '/detect'
        url = translator_endpoint + path

        # Build the request
        params = {
            'api-version': '3.0'
        }

        headers = {
        'Ocp-Apim-Subscription-Key': cog_key,
        'Ocp-Apim-Subscription-Region': cog_region,
        'Content-type': 'application/json'
        }

        body = [{
            'text': text
        }]

        # Send the request and get response
        request = requests.post(url, params=params, headers=headers, json=body)
        response = request.json()

        # Parse JSON array and get language
        language = response[0]["language"]

    Translate Text:

    In the Translate function, under the comment Use the Translator translate function, add the following code to use the Translator's REST API to translate the specified text from its source language into English

    # Use the Translator translate function
    path = '/translate'
    url = translator_endpoint + path

    # Build the request
    params = {
        'api-version': '3.0',
        'from': source_language,
        'to': ['en']
    }

    headers = {
        'Ocp-Apim-Subscription-Key': cog_key,
        'Ocp-Apim-Subscription-Region': cog_region,
        'Content-type': 'application/json'
    }

    body = [{
        'text': text
    }]

    # Send the request and get response
    request = requests.post(url, params=params, headers=headers, json=body)
    response = request.json()

    # Parse JSON array and get translation
    translation = response[0]["translations"][0]["text"]

    Documenation:https://docs.microsoft.com/en-us/azure/cognitive-services/translator/