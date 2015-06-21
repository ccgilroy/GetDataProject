---
title: "README"
author: "Connor Gilroy"
output: html_document
---

This project is for the _Getting and Cleaning Data_ course by JHU on Coursera. It takes a raw data set of Samsung smartphone data and produces a tidy data set which summarizes some of the measured and calculated features of the original data.  

The project consists of three files:  

* This `README.md`, which describes the contents of the project and how the script works 
* `CodeBook.md`, which describes the variables and data sets produced by the R script
* `run_analysis.R`, an R script which tidies and aggregates the UCI HAR Dataset

`run_analysis.R` takes the UCI HAR Dataset from the working directory and outputs `tidydata.txt` to the working directory. It makes use of the `dplyr` and `tidyr` packages by Hadley Wickham.

The script accomplishes this via the following steps:

0. (Optional: If the UCI HAR Dataset is not present in the working directory, the script will download and unzip it into the working directory.)
1. It reads in the appropriate text files from the test and train folders. It combines the variables (activity, subject, and features) into two data frames by column, then combines the test and train data frames by row. Note that activity is read in as a factor variable to facility renaming later.
2. From the combined data frame, it uses `select()` and a regular expression to select the feature variables which are means or standard deviations. (`meanFreq()` is excluded because it has no corresponding standard deviation.)
3. In the extracted data frame, the activity variable's values are renamed using factor level assignment, based on the names in `activity_labels.txt`.
4. The feature variables are cleaned and renamed using a series of regular expressions. All extraneous numbers and punctuation are removed and abbreviations are expanded into full words. The end result is 66 feature names, all lower case with no spaces, listed in `CodeBook.md`.
5. The feature variables are summarized using mean values by activity and subject. This is done in two ways: 
    1. Wide form: groups the rows by activity and subject and applies the `mean()` function to each of the other columns using `summarise_each()`.
    2. Long form: `gather()`s all of the variables except activity and subject into a key column, `feature`, and a value column, `value`. Groups rows by activity, subject and feature, and summarizes by the `mean()` function to the value column, renaming it `meanvalue`.
    
    The resulting long form data frame is saved to `tidydata.txt` using `write.table()` with `row.names=FALSE`.

To read the data frame produced by `run_analysis.R` back into R:

    data <- read.table("tidydata.txt", header=TRUE)
    
(Credit to [Dave's personal course project FAQ](https://class.coursera.org/getdata-015/forum/thread?thread_id=26))

run_analysis.R can also be modified to output the data in wide form rather than long form.

To do this, replace `new.data.long` with `new.data.wide`:

    write.table(new.data.wide, "tidydata.txt", row.names=FALSE)