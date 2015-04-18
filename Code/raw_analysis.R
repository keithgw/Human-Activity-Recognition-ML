---
title: "Human Activity Recognition Machine Learning Project"
author: "Keith G. Williams"
date: "Wednesday, April 15, 2015"
output: html_document
---

## Executive Summary

## Load and Partition Data
```{r}
library(caret)
library(ggplot2)
library(dplyr)

file_train <- "../Data/pml-training.csv"
data_wel <- read.csv(file_train, 
                     stringsAsFactors = FALSE,
                     na.strings = c("", "NA", "#DIV/0!"))

# convert classe to factor
data_wel$classe <- factor(data_wel$classe)

# remove index column
data_wel <- data_wel[-1:-7]

# partition data for training and testing
set.seed(1201)
inTrain <- createDataPartition(data_wel$classe, p=0.7, list=FALSE)
training <- data_wel[inTrain,]
testing <- data_wel[-inTrain,]

# remove columns with > 50% NA
cols_na <- integer()
for (i in 1:ncol(training)) {
    if(mean(is.na(training[i])) > .5) {
        cols_na <- c(cols_na, i)
    }
}
training <- training[-cols_na]
testing <- testing[-cols_na]

# remove columns with near zero variance
features_nzv <- nearZeroVar(training)
training <- training[-features_nzv]
testing <- testing[-features_nzv]

fit <- train(classe ~ ., data = training, method = "rf")
```

## Exploratory Data Analysis

## Model

### Cross Validation

## Out of Sample Error