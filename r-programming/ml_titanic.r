library(caret)
library(tidyverse)
library(titanic)
library(dplyr)

df <- titanic_train
view(df)

## Preview Data
head(df)
tail(df)
glimpse(df)
sum(complete.cases(df))

## Prep Data
df$Pclass <- as.factor(df$Pclass)
df$Sex <- as.factor(df$Sex)
df <- drop_na(df)

## Split Data
set.seed(42)
n <- nrow(df)
id <- sample(1:n, size = n * 0.8)
train_data <- df[id, ]
test_data <- df[-id, ]

## train model
logis_model <- glm(Survived ~ Sex + Age + Pclass,
                   data = train_data,
                   family = "binomial")

log_predict_train <- predict(logis_model,
                             type = "response")
train_data$pred <- if_else(log_predict_train > 0.5, 1, 0)
train_acc <- mean(train_data$Survived == train_data$pred)

## scoring
log_predict_test <- predict(logis_model,
                            newdata = test_data,
                            type = "response")
test_data$pred <- if_else(log_predict_test > 0.5, 1, 0)
test_acc <- mean(test_data$Survived == test_data$pred)

## Evaluate
confus <- table(train_data$Survived, train_data$pred,
      dnn = c("actual", "predicted"))

## Accuracy
acc <- (confus[1,1] + confus[2,2]) / sum(confus)

## Precision
pre <- confus[2,2] / (confus[2,1] + confus[2,2])

## Recall
rec <- confus[2,2] / (confus[1,2] + confus[2,2])

## F1 Score
f1_score <- 2*((pre * rec) / (pre + rec))
