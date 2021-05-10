Speech:
    code  doesnt work

    Setup:

    pip install azure-cognitiveservices-speech==1.14.0
    # Import namespaces
    import azure.cognitiveservices.speech as speech_sdk
    In the Main function, note that code to load the cognitive services key and region from the configuration file has already been provided. You must use these variables to create a SpeechConfig for your cognitive services resource# Configure speech service
    speech_config = speech_sdk.SpeechConfig(cog_key, cog_region)
    print('Ready to use speech service in:', speech_config.region)

    Recognise Speech:

        For microphone:
            In the Main function for your program, note that the code uses the TranscribeCommand function to accept spoken input.
            
            # Configure speech recognition
            audio_config = speech_sdk.AudioConfig(use_default_microphone=True)
            speech_recognizer = speech_sdk.SpeechRecognizer(speech_config, audio_config)
            print('Speak now...')

        for audio file:
            pip install playsound==1.2.2
            from playsound import playsound# Configure speech recognition
            audioFile = 'time.wav'
            playsound(audioFile)
            audio_config = speech_sdk.AudioConfig(filename=audioFile)
            speech_recognizer = speech_sdk.SpeechRecognizer(speech_config, audio_config)

         Add code to process the transcribed command:

            # Process speech input
            speech = speech_recognizer.recognize_once_async().get()
            if speech.reason == speech_sdk.ResultReason.RecognizedSpeech:
                command = speech.text
                print(command)
            else:
                print(speech.reason)
                if speech.reason == speech_sdk.ResultReason.Canceled:
                    cancellation = speech.cancellation_details
                    print(cancellation.reason)
                    print(cancellation.error_details)
            
            If using a microphone, speak clearly and say "what time is it?". The program should transcribe your spoken input and display the time (based on the local time of the computer where the code is running, which may not be the correct time where you are).

            The SpeechRecognizer gives you around 5 seconds to speak. If it detects no spoken input, it produces a "No match" result.

            If the SpeechRecognizer encounters an error, it produces a result of "Cancelled". The code in the application will then display the error message. The most likely cause is an incorrect key or region in the configuration file.

    Synthesize speech:

        In the Main function for your program, note that the code uses the TellTime function to tell the user the current time

        # Configure speech synthesis
        speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config)

        Note: The default audio configuration uses the default system audio device for output, so you don't need to explicitly provide an AudioConfig. If you need to redirect audio output to a file, you can use an AudioConfig with a filepath to do so.

        # Synthesize spoken output
        speak = speech_synthesizer.speak_text_async(response_text).get()
        if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
            print(speak.reason)
    
    Using a different voice:

        Note: For a list of neural and standard voices, see Language and voice support in the Speech service documentation.
        Documenation: https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/language-support#text-to-speech

        Modify the Configure speech synthesis part(Into below code):
        # Configure speech synthesis
        speech_config.speech_synthesis_voice_name = 'en-GB-George' # add this
        speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config)

    Speech Synthesis Markup Language:

    Speech Synthesis Markup Language (SSML) enables you to customize the way your speech is synthesized using an XML-based format.

    # Synthesize spoken output
    responseSsml = " \
        <speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='en-US'> \
            <voice name='en-GB-Susan'> \
                {} \
                <break strength='weak'/> \
                Time to end this lab! \
            </voice> \
        </speak>".format(response_text)
    speak = speech_synthesizer.speak_ssml_async(responseSsml).get()
    if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
        print(speak.reason)

    When prompted, speak clearly into the microphone and say "what time is it?". The program should speak in the voice that is specified in the SSML (overriding the voice specified in the SpeechConfig), telling you the time, and then after a pause telling you it's time to end this lab - which it is!

    Documenation: https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/index-speech-to-text
    https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/index-text-to-speech
