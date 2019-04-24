# ML method research
## Visual Recognition models on IBM Watson Studio
[Link to IBM Watson Visual Recognition service](https://www.ibm.com/cloud/watson-visual-recognition)
### 1. Get your training images ready

Here we use 00002_NEW IN_WOMAN_excel.xlsx downloaded from ZARA website. It contains info of cloths of ZARA with image link available.
Then we use a script get_all_images.py to get all cloths images.

### 2. Label your training images and upload them to Watson Studio

Divide your training images to two folders, one is like, another is dislike.
Upload the images in like folder to class like, upload the images in dislike folder to default Negative class.

![create image class](https://github.com/SJSU272Spring2019/Project-Group-6/blob/master/ml%20method/images/1.png)

### 3. Train your model with one button click!

### 4. Test your model with testing images

The model will give a possibility of how this test image belongs to like class.
![test image](https://github.com/SJSU272Spring2019/Project-Group-6/blob/master/ml%20method/images/2.png)


## Watson Machine Learning models
We also tried this machine learning model service on Watson Studio. 
[Link to IBM Watson Machine Learning service](https://www.ibm.com/cloud/machine-learning)

This machine learning model will take in a table containing information of cloths as training data. We got this excel file from ZARA website.
You can choose a column as predictive column. After training, you can test the model by entering new values of columns except predictive column.
You will get a prediction for the predictive column.

![test](https://github.com/SJSU272Spring2019/Project-Group-6/blob/master/ml%20method/images/3.png)
