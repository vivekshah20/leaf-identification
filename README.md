A Leaf Identification System
=============================

### Summary
It is an algorithm to identify leaves from a set of 10 different leaves and also to calculate its chlorophyll and nitrogen content



### Pre-requisites
1. Leaf should be kept on a white sheet.
2. Camera should be approximately 15 cm away from the leaf while identifying the leaf whereas the camera should be as close as possible to the leaf while calculating the chlorophyll and nitrogen content(just make sure the whole leaf is visible in the image)
3. There should not be any shadow in the leaf image.
4. Leaf image should be taken in such a way that it should have only leaf and white paper in it.

To run the program:
1. Go to leaf_identification_system\predict_leaf.m  (I have used my android phone as a webcam using a free app called ipcamera from playstore to capture the image.)
2. Replace the url mentioned in predict_leaf.m file to your ipcamera url 
3. click on "open webcam" option in GUI
4. Once you are satisfied with the image, click on "click picture"
5. Then press the option "Predict leaf" and wait for sometime, the result will come to its right (this will take around 40 seconds)
6. Similarly to get the chlorophyll content, click on "Find chlorophyll" and its result will come to its right side
7. Lastly, to get the Nitrogen content, click on "find nitrogen"


###Identification of Leaves

Procedure:
1. Once the leaf is captured, it is saved as original_image 
2. In order to subtract the white part from the whole image and detect the geometrical shape of the leaf 
   it is found that value of B in RGB image should be less than 60
3. Apply the complement function to make the white portion as leaf and black portion as background
4. Fill all the small unwanted holes in the leaf
5. find geometrical features of the image using the matlab function "regionprops"
6. To get the textural features, convert the image into its gray scale form and then use the matlab formula "graycoprops"
7. save all the features extracted in a file "training.xlsx"

Training and testing:
(To train the data, I have used multiclass(one vs all) logistic regression)

1. Get the data from training
2. Normalize it using max-min normalization
3. save the max and min values in an excel file for testing purpose
4. Now, use matlab function "cvpartition" to get the training and testdata
5. Assign lamda value as 0.011
6. Now apply onevsAll to get the theta values for each class
7. Apply predictOneVsAll to get the predicted classes for the test data
8. Find the accuracy of the system

Features extracted:
1. aspect ratio
2. rectangularity
3. convex area ratio
4. eccentricity
5. diameter
6. form factor
7. narrow factor
8. perimeter ratio
9. solidity
10.circularity
11. irrgularity
12. zernike moment
13. Hu invariants
14. contrast
15. homogeneity
16. correlation
17.	energy
18. entropy
 
(Total feature columns - 37 )


###Chlorophyll Content

Procedure:
1. Check the B component value in RGB ,
	if it is greater than 90, then it is white paper, 
	else
	it is leaf
2. Find the leaf area in the image and make the background as black 
3. find mean of each RGB component in the leaf image
4. use the cholorophyll formula i.e.
	choloro = G -(R/2) -(B/2)
	
	
###Nitrogen Content

Procedure:
1. Check the B component value in RGB ,
	if it is greater than 90, then it is white paper, 
	else
	it is leaf
2. Find the leaf area in the image and make the background as black 
3. Find the average of each component and divide it by 255 (to get average in 0 to 1)
4. find max and min among these average values
5. Find the HSB values using the below mentioned algorithm
   if max = R average
		Hue =((G -B)/(max-min))*60
	if max = G average
		Hue = (((B-R)/(max-min))+2)*60
    if max = B average
		Hue =(((R-G)/(max-min))+4)*60
    saturation = ( max - min )/ max	
	Brightness = max
6. nitrogen content =	((H - 60)/60 + (1 - S) + (1 - B))/3

###References:

Nitrogen & Chlorophyll
1. Karcher, D. E., & Richardson, M. D. (2003). Quantifying turfgrass color using digital image analysis. Crop Science, 43(3), 943-951
2. Ali, M. M., Al-Ani, A., Eamus, D., & Tan, D. K. (2013). An Algorithm Based on the RGB Colour Model to Estimate Plant Chlorophyll and Nitrogen Contents. International Proceedings of Chemical, Biological & Environmental Engineering, 57.

Identification System
1.  Knight, D., Painter, J., & Potter, M. (2010). Automatic plant leaf classification for a mobile field guide. Rapport technique, Université de Stanford.
2.	Cope, J. S., Corney, D., Clark, J. Y., Remagnino, P., & Wilkin, P. (2012). Plant species identification using digital morphometrics: A review. Expert Systems with Applications, 39(8), 7562-7573
3.	Patil, S., Soma, S., & Nandyal, S. (2013). Identification of Growth Rate of Plant based on leaf features using Digital Image Processing Techniques.International Journal of Emerging Technology and Advanced Engineering, 3(8), 266-275
4.	Kulkarni, A. H., Rai, H. M., Jahagirdar, K. A., & Upparamani, P. S. (2013). A Leaf Recognition Technique for Plant Classification Using RBPNN and Zernike Moments. International Journal of Advanced Research in Computer and Communication Engineering, 2(1), 1-5
5.  Bama, B. S., Valli, S. M., Raju, S., & Kumar, V. A. (2011). Content based leaf image retrieval (CBLIR) using shape, color and texture features. Indian Journal of Computer Science and Engineering, 2(2), 202-211
5.	Wu, S. G., Bao, F. S., Xu, E. Y., Wang, Y. X., Chang, Y. F., & Xiang, Q. L. (2007, December). A leaf recognition algorithm for plant classification using probabilistic neural network. In Signal Processing and Information Technology, 2007 IEEE International Symposium on (pp. 11-16). IEEE
6.	Chaki, J., & Parekh, R. (2011). Plant leaf recognition using shape based features and neural network classifiers. International Journal of Advanced Computer Science and Applications (IJACSA), 2(10)
7.	Ab Jabal, M. F., Hamid, S., Shuib, S., & Ahmad, I. (2013). Leaf features extraction and recognition approaches to classify plant. Journal of Computer Science, 9(10), 1295
8.	Ehsanirad, A., & Sharath Kumar, Y. H. (2010). Leaf recognition for plant classification using GLCM and PCA methods. Oriental Journal of Computer Science and Technology, 3(1), 31-36
9.	Rao, P. B., Prasad, D. V., & Kumar, C. P. Feature Extraction Using Zernike Moments
10.	Vorobyov, M. (2011). Shape Classification Using Zernike Moments. Technical Report. iCamp-University of California Irvine
