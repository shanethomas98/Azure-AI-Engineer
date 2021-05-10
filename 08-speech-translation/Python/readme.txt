Speech Translation:

    pip install azure-cognitiveservices-speech==1.14.0
    # Import namespaces
    import azure.cognitiveservices.speech as speech_sdk


    in Main
    # Configure translation
    translation_config = speech_sdk.translation.SpeechTranslationConfig(cog_key, cog_region)
    translation_config.speech_recognition_language = 'en-US'
    translation_config.add_target_language('fr')
    translation_config.add_target_language('es')
    translation_config.add_target_language('hi')
    print('Ready to translate from',translation_config.speech_recognition_language)

    SpeechTranslationConfig
    # Configure speech
    speech_config = speech_sdk.SpeechConfig(cog_key, cog_region)

    Speech Translation(for Microphone):

        In Translate Function:
        # Translate speech
            audio_config = speech_sdk.AudioConfig(use_default_microphone=True)
            translator = speech_sdk.translation.TranslationRecognizer(translation_config, audio_config)
            print("Speak now...")
            result = translator.recognize_once_async().get()
            print('Translating "{}"'.format(result.text))
            translation = result.translations[targetLanguage]
            print(translation)

        Note: The code in your application translates the input to all three languages in a single call. Only the translation for the specific language is displayed, but you could retrieve any of the translations by specifying the target language code in the translations collection of the result.

    For Audio file:

        pip install playsound==1.2.2
        from playsound import playsound

        In translate function:
            # Translate speech
            audioFile = 'station.wav'
            playsound(audioFile)
            audio_config = speech_sdk.AudioConfig(filename=audioFile)
            translator = speech_sdk.translation.TranslationRecognizer(translation_config, audio_config)
            print("Getting speech from file...")
            result = translator.recognize_once_async().get()
            print('Translating "{}"'.format(result.text))
            translation = result.translations[targetLanguage]
            print(translation)
        
        Note: The code in your application translates the input to all three languages in a single call. Only the translation for the specific language is displayed, but you could retrieve any of the translations by specifying the target language code in the translations collection of the result.

        When prompted, enter a valid language code (fr, es, or hi), and then, if using a microphone, speak clearly and say "where is the station?" or some other phrase you might use when traveling abroad. The program should transcribe your spoken input and translate it to the language you specified (French, Spanish, or Hindi). Repeat this process, trying each language supported by the application. When you're finished, press ENTER to end the program.

        Note: The TranslationRecognizer gives you around 5 seconds to speak. If it detects no spoken input, it produces a "No match" result.
        The translation to Hindi may not always be displayed correctly in the Console window due to character encoding issues.

    Synthesize the translation to speech:
        # Synthesize translation
        voices = {
                "fr": "fr-FR-Julie",
                "es": "es-ES-Laura",
                "hi": "hi-IN-Kalpana"
        }
        speech_config.speech_synthesis_voice_name = voices.get(targetLanguage)
        speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config)
        speak = speech_synthesizer.speak_text_async(translation).get()
        if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
            print(speak.reason)

    When prompted, enter a valid language code (fr, es, or hi), and then speak clearly into the microphone and say a phrase you might use when traveling abroad. The program should transcribe your spoken input and respond with a spoken translation. Repeat this process, trying each language supported by the application. When you're finished, press ENTER to end the program.
    Note: In this example, you've used a SpeechTranslationConfig to translate speech to text, and then used a SpeechConfig to synthesize the translation as speech. You can in fact use the SpeechTranslationConfig to synthesize the translation directly, but this only works when translating to a single language, and results in an audio stream that is typically saved as a file rather than sent directly to a speaker.

    Documenation: https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/index-speech-translation
    
