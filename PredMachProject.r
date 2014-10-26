---
title: "Human Activity Recognition with Machine Learning Techniques"
author: "Dave Friedman"
date: "Saturday, October 25, 2014"
output: "html_document"
---


## Get the Data
```{r, results="hide"}
setwd("Project")

trainURL<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testURL <-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(trainURL, "pml-training.csv")
download.file(testURL, "pml-testing.csv")

problem.set <- read.csv("pml-testing.csv")
df <- read.csv("pml-training.csv")
```

## Clean the Data
```{r}
## Remove all rows with New Window
df <- df[df$new_window == "no",] 

## Remove all rows whose values are completely NA and then who are completely empty
df <- df[, colSums(is.na(df)) != nrow(df)]
df <- df[, colSums(df=="") != nrow(df)]
df <- df[-(1:7)]

## Apply Transformations to Problem Set
## Problem Set has lacks New Windows
problem.set <- problem.set[, colSums(is.na(problem.set)) != nrow(problem.set)]
problem.set <- problem.set[, colSums(problem.set=="") != nrow(problem.set)]
problem.set <- problem.set[-(1:7)]
```

## Explore the Data
```{r}

```

## Model the Data
```{r, cache=TRUE}
## Create Train & Test Sets
set.seed(212)
in.train <- createDataPartition(y=df$classe, p=0.6, list=FALSE)
train <- df[ in.train,]
test  <- df[-in.train,]

fit <- train(classe~., data=train, method="gbm")
```

## Confirm the Model's Accuracy
```{r}
## In-Sample Accuracy
predicted.train <- predict(fit, train)
confusionMatrix(predicted.training, train$classe)

## Out-of-Sample Accuracy
predicted.test <- predict(fit, test)
confusionMatrix(predicted.test, test$classe)
```

## Predicting the Problem Set with the Model
```{r}
## Predict Classe based on Problem Set data & Model
answers <- predict(fit, problem.set)
answers <- as.character(answers)
answers
```

## Write to Files
```{r}
pml_write_files = function(x){
    n = length(x)
    for(i in 1:n){
        filename = paste0("problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
    }
}

setwd("Answers")
pml_write_files(answers)
setwd("../")
```

## Conclusion


You can also embed plots, for example:

```{r, echo=FALSE}

```
