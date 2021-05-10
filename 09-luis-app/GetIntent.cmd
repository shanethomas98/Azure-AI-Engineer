@echo off

rem Set values for your Language Understanding app
set app_id=e4da75b6-7662-449b-b946-91e241e224d7
set endpoint=https://langauage-undersatnding.cognitiveservices.azure.com/
set key=4496bb79fff245889c947a32ec0afd44

rem Get parameter and encode spaces for URL
set input=%1
set query=%input: =+%

rem Use cURL to call the REST API
curl -X GET "%endpoint%/luis/prediction/v3.0/apps/%app_id%/slots/production/predict?subscription-key=%key%&log=true&query=%query%"