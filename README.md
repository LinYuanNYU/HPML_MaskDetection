# HPML_MaskDetection
# Dataset
The dataset used in this project is https://www.kaggle.com/datasets/andrewmvd/face-mask-detection

The dataset has three catagories: wear a mask, not wear a mask, wear a mask inapporpiately.

## Data Preprocessing
For this part, I did not use imaug python package. I found a powerful online platform can help us to do that: roboflow(https://roboflow.com)
The augmentation I utilized is shown below:

<img width="477" alt="Screen Shot 2022-05-16 at 09 13 14" src="https://user-images.githubusercontent.com/42855203/168600517-093f3497-3e69-43c3-9a79-9c527e86005a.png">

<img width="255" alt="image" src="https://user-images.githubusercontent.com/42855203/168605419-6672cf33-947c-4275-8484-c9b8f530850e.png">

I did a 5X dataset augmentation. In the end, the dataset has around 3K images.

## Training
With some literature review, I found that Yolov5 is basically one of the most advanced real-time one-stage object detection network that has the best open-source support. Thus, in this experiment, I chose Yolov5. Their official repo: https://github.com/ultralytics/yolov5. Yolov5 is a seriers of networks, which differs in parameter size. In this experiment, I trained 4 of them. The result is listed as below:
Model Name | Input Image Size | Parameters(M) | Inference Time (Tesla V100, ms) | mAp(IoU threshold = 0.5) |
--- | --- | --- | --- |--- |
Yolov5s | 640 | 7.2 | 9.8 | 77.665% |
Yolov5m | 640 | 21 | 12.4 | 80.337% |
Yolov5x | 640 | 86.7 | 29.7 | 79.653% |
Yolov5l6 | 1280 | 76.8 | 25.9 | 83.805% |

Obviously, Yolov5l6 has the best result with input image size as 1280 * 1280. Indeed, in the following test, this model gives nearly perfect results.

## Evaluation
the highest mAP I achieved is 83.8%. I did some analysis, the main defective factor is the detection of class "wearing masks inapporpiately". For further improvement, we can focus on this direction. For example, do some class-specific image augmentation of the dataset.

Here's one image shows the ability of this network:

<img width="923" alt="image" src="https://user-images.githubusercontent.com/42855203/168602742-edb2c4ee-97d0-447d-97ba-68e806849e37.png">

![GettyImages-1197642798 (3)](https://user-images.githubusercontent.com/42855203/168602655-cceda43d-66ab-4959-ae2b-f68c1b1db35e.jpg)
 
 Here's one image shows that the model also performs well when detecting many objects that are relative small in the image:
 
![image](https://user-images.githubusercontent.com/42855203/168605139-ad76ba22-e6a5-4564-8a52-8fc13fd6ee27.jpeg)

 
 ## Predicting
 I deployed the model to three platfroms: Linux server, Desktop Computer and Mobile IOS devices.
 For linux server, the inference results are shown above.
 
 ### Webcam detection:
 
 ![image](https://user-images.githubusercontent.com/42855203/168605211-2c290b86-2433-4c41-a6ab-4ff3f44fb394.jpeg)
![image](https://user-images.githubusercontent.com/42855203/168604568-4993e7f0-46eb-470d-93a5-86248d387891.jpeg)
![image](https://user-images.githubusercontent.com/42855203/168604592-4a2f43c9-1741-4436-b4fe-5d7d433703aa.jpeg)

### IOS Application:
In order to run the model on a IOS Application, I exported the pth model trained by Pytorch into Apple CoreML model and depolyed it onto the mobile phone. Thanks to Ultralytics (https://ultralytics.com/hub), the author of Yolov5 models, we can use camera of our phone to do the detection.

The IOS application mainly has two pages. The first one is shown on left, which is choosing model we want to use to do inference. The main page is shown on the right side. It uses the main camera and run the model. The inference time for each frame is desplayed on the top.

<img width="383" alt="image" src="https://user-images.githubusercontent.com/42855203/168605790-9e9fa29c-b8eb-4036-93ee-ebb7e9142a82.png">


