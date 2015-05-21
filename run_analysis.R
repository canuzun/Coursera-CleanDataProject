rm(list=ls())
setwd("S:/POC/Data Science/Coursera/Getting and Cleaning Data/Assignment-Project")
datasetRootPath = "S:/POC/Data Science/Coursera/Getting and Cleaning Data/Assignment-Project/UCI HAR Dataset/"

#lets get data
tmpPath = paste(datasetRootPath, "test/subject_test.txt", sep="")
subject_test = read.csv(file= tmpPath, header=F)

tmpPath = paste(datasetRootPath, "test/X_test.txt", sep="")
X_test = read.table(file= tmpPath, header=F)

tmpPath = paste(datasetRootPath, "test/y_test.txt", sep="")
y_test = read.csv(file= tmpPath, header=F)

tmpPath = paste(datasetRootPath, "train/subject_train.txt", sep="")
subject_train = read.csv(file= tmpPath, header=F)

tmpPath = paste(datasetRootPath, "train/X_train.txt", sep="")
X_train = read.table(file= tmpPath, header=F)

tmpPath = paste(datasetRootPath, "train/y_train.txt", sep="")
y_train = read.csv(file= tmpPath, header=F)

#append train to test in _all objects and clear workspace a little bit
subject_all = rbind(subject_test, subject_train)
X_all = rbind(X_test, X_train)
y_all = rbind(y_test, y_train)

rm("subject_test", "subject_train", "X_test", "X_train", "y_test", "y_train")

#lets get reference values and use factor labels
tmpPath = paste(datasetRootPath, "activity_labels.txt", sep="")
activity_labels = read.csv(file= tmpPath, header=F, sep =" ")

f = factor(activity_labels[,1], labels =activity_labels[,2])
y_all = data.frame(sapply(y_all, function(x) f[x]))

#add headers to X_all data frame
tmpPath = paste(datasetRootPath, "features.txt", sep="")
features = read.csv(file= tmpPath, header=F, sep =" ")

f = factor(1:length(X_all), labels = features[,2])
names(X_all) = f

#remove duplicate and weird columns like fBodyGyro-bandsEnergy()-33,40
X_all = X_all[,!duplicated(colnames(X_all))]

#pick means and standard deviation data
library(dplyr)
means = select(X_all, contains("mean()"))
stds = select(X_all, contains("std()"))

#create final dataset
dsFinal = cbind(means,stds)

#add other data to X_all as new columns
names(y_all)[1] = "Activity"
head(y_all)
dsFinal$Activity = y_all[,1]
names(subject_all)[1] = "Subject"
dsFinal$Subject = subject_all[,1]

#a little cleanup
rm("X_all", "means", "stds", "y_all", "subject_all", "features", "activity_labels")

x = ncol(dsFinal) - 2 #not include Activity & Subject columns
tidy = aggregate(dsFinal[1:x], by=dsFinal[c("Activity","Subject")], FUN=mean)

write.table(tidy, file="tidy_dataset.txt", row.name=FALSE)

























