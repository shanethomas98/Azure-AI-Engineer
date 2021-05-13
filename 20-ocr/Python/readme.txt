Read Text Images:
    Setup: pip install azure-cognitiveservices-vision-computervision==0.7.0
    Code:
        # import namespaces
        from azure.cognitiveservices.vision.computervision import ComputerVisionClient
        from azure.cognitiveservices.vision.computervision.models import OperationStatusCodes
        from msrest.authentication import CognitiveServicesCredentials
    
    In Main:
        # Authenticate Computer Vision client
        credential = CognitiveServicesCredentials(cog_key) 
        cv_client = ComputerVisionClient(cog_endpoint, credential)
    
    Use OCR API(Option 1 when running, for small to medium amount of text):

    # Use OCR API to read text in image
    with open(image_file, mode="rb") as image_data:
        ocr_results = cv_client.recognize_printed_text_in_stream(image_data)

    # Prepare image for drawing
    fig = plt.figure(figsize=(7, 7))
    img = Image.open(image_file)
    draw = ImageDraw.Draw(img)

    # Process the text line by line
    for region in ocr_results.regions:
        for line in region.lines:

            # Show the position of the line of text
            l,t,w,h = list(map(int, line.bounding_box.split(',')))
            draw.rectangle(((l,t), (l+w, t+h)), outline='magenta', width=5)

            # Read the words in the line of text
            line_text = ''
            for word in line.words:
                line_text += word.text + ' '
            print(line_text.rstrip())

    # Save the image with the text locations highlighted
    plt.axis('off')
    plt.imshow(img)
    outputfile = 'ocr_results.jpg'
    fig.savefig(outputfile)
    print('Results saved in', outputfile)

    Read API(Option 2 when the code is run, for text heavy images):
    # Use Read API to read text in image
    with open(image_file, mode="rb") as image_data:
        read_op = cv_client.read_in_stream(image_data, raw=True)

        # Get the async operation ID so we can check for the results
        operation_location = read_op.headers["Operation-Location"]
        operation_id = operation_location.split("/")[-1]

        # Wait for the asynchronous operation to complete
        while True:
            read_results = cv_client.get_read_result(operation_id)
            if read_results.status not in [OperationStatusCodes.running, OperationStatusCodes.not_started]:
                break
            time.sleep(1)

        # If the operation was successfuly, process the text line by line
        if read_results.status == OperationStatusCodes.succeeded:
            for page in read_results.analyze_result.read_results:
                for line in page.lines:
                    print(line.text)
        
        Hardwriting sample:
        Run code with option 3

Documentation: https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/overview-ocr