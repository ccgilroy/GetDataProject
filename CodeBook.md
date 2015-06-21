---
title: "Code Book"
author: "Connor Gilroy"
output: html_document
---

This code book supplements `features_info.txt` and `activity_labels.txt` in the UCI HAR Dataset to describe the variables present in the tidied and transformed data sets produced by `run_analysis.R`.

## Variables

### Fixed variables

* activity: one of six possible actions that subjects could be measured while performing. These are identified by numbers 1-6 in the original data, and by name in the cleaned data sets:
    1. walking
    2. walking upstairs
    3. walking downstairs
    4. sitting
    5. standing
    6. laying
* subject: one of thirty possible participants in the study, identified by number.

### Measured variables

#### Features
66 of the 561 features produced in the original study to describe the raw smartphone data have been extracted into the `extracted.data` and `new.data` data sets. Those 66 features have been renamed with full, descriptive names. The components which comprise those names are 

* `time` and `fft`: each feature is either a time domain signal or a Fast Fourier Transform of that time signal into a frequency, respectively. 
* `body` and `gravity`: acceleration measurements are separated into the acceleration of the subject's body and the acceleration due to gravity. All gyroscope measurements pertain to the subject's body.
* `acceleration` and `gyroscope`: measurements either come from the accelerometer and are in units of _g_ (or a derivation), or from the gyroscope and are measurements of angular velocity in units of radians/second.
* `mean` and `std`: each feature is either the mean or standard deviation of an original set of measurements, respectively. 
* `xaxis`, `yaxis`, and `zaxis`: the 3-dimensional axes in space for the original acceleration and gyroscope measurements.
* `jerk`: derivation in time of acceleration and angular velocity. 
* `magnitude`: Euclidean norm magnitude of three-dimensional signals.

Descriptions based on `features_info.txt`. See [below](#full-list-of-feature-names) for a full list of feature names.

#### Values & mean values
Per Anguita et al., the features are all normalized and bounded within [-1, 1]. The originally measured acceleration features are in standard gravity units _g_, while the gyroscope features are in units of radians/second.

## Data transformations

* Raw data: a series of text files divided into test and train data. Separate text files contain the activity, subject, and feature data.
* Combined data: train and test data frames combine the above text files by columns, and then are combined together by rows. 
* Extracted data: selects a subset of the feature variable columns in the combined data, to only include the mean and standard deviation measurements. Renames those variables to have more descriptive names.
* New transformed data: summarizes the extracted data by taking the mean of each feature for each activity-subject combination. This data set is present in both wide form (each feature variable in its own column) and long form (all of the feature variables )

## Appendix

#### Full list of feature names

* timebodyaccelerationmeanxaxis
* timebodyaccelerationmeanyaxis
* timebodyaccelerationmeanzaxis
* timebodyaccelerationstdxaxis
* timebodyaccelerationstdyaxis
* timebodyaccelerationstdzaxis
* timegravityaccelerationmeanxaxis
* timegravityaccelerationmeanyaxis
* timegravityaccelerationmeanzaxis
* timegravityaccelerationstdxaxis
* timegravityaccelerationstdyaxis
* timegravityaccelerationstdzaxis
* timebodyaccelerationjerkmeanxaxis
* timebodyaccelerationjerkmeanyaxis
* timebodyaccelerationjerkmeanzaxis
* timebodyaccelerationjerkstdxaxis
* timebodyaccelerationjerkstdyaxis
* timebodyaccelerationjerkstdzaxis
* timebodygyroscopemeanxaxis
* timebodygyroscopemeanyaxis
* timebodygyroscopemeanzaxis
* timebodygyroscopestdxaxis
* timebodygyroscopestdyaxis
* timebodygyroscopestdzaxis
* timebodygyroscopejerkmeanxaxis
* timebodygyroscopejerkmeanyaxis
* timebodygyroscopejerkmeanzaxis
* timebodygyroscopejerkstdxaxis
* timebodygyroscopejerkstdyaxis
* timebodygyroscopejerkstdzaxis
* timebodyaccelerationmagnitudemean
* timebodyaccelerationmagnitudestd
* timegravityaccelerationmagnitudemean
* timegravityaccelerationmagnitudestd
* timebodyaccelerationjerkmagnitudemean
* timebodyaccelerationjerkmagnitudestd
* timebodygyroscopemagnitudemean
* timebodygyroscopemagnitudestd
* timebodygyroscopejerkmagnitudemean
* timebodygyroscopejerkmagnitudestd
* fftbodyaccelerationmeanxaxis
* fftbodyaccelerationmeanyaxis
* fftbodyaccelerationmeanzaxis
* fftbodyaccelerationstdxaxis
* fftbodyaccelerationstdyaxis
* fftbodyaccelerationstdzaxis
* fftbodyaccelerationjerkmeanxaxis
* fftbodyaccelerationjerkmeanyaxis
* fftbodyaccelerationjerkmeanzaxis
* fftbodyaccelerationjerkstdxaxis
* fftbodyaccelerationjerkstdyaxis
* fftbodyaccelerationjerkstdzaxis
* fftbodygyroscopemeanxaxis
* fftbodygyroscopemeanyaxis
* fftbodygyroscopemeanzaxis
* fftbodygyroscopestdxaxis
* fftbodygyroscopestdyaxis
* fftbodygyroscopestdzaxis
* fftbodyaccelerationmagnitudemean
* fftbodyaccelerationmagnitudestd
* fftbodybodyaccelerationjerkmagnitudemean
* fftbodybodyaccelerationjerkmagnitudestd
* fftbodybodygyroscopemagnitudemean
* fftbodybodygyroscopemagnitudestd
* fftbodybodygyroscopejerkmagnitudemean
* fftbodybodygyroscopejerkmagnitudestd