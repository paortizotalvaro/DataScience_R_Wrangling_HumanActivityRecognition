# README run_analysis.R

This is a single script that cleans a data set on human activity recognition 

# Data set
Source: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
[Download](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/)

# How to clean this data set using run_analysis.R

Note:
You should have installed both dplyr and data.table in RStudio before following the next steps.

1. Download the data. It should be inside a folder called _UCI HAR Dataset_
2. Download run_analysis.R and locate it in the parent folder of _UCI HAR Dataset_
3. Open run_analysis.R in RStudio. Set your working directory to the folder where run_analysis.R is located (i.e. the parent folder of _UCI HAR Dataset_).
4. Run the script in RStudio  

`Run source("run_analysis.R")`

A new file called _har_clean.csv_ should appear in your current working directory with the resulting data set after the wrangling process.





