library(titanic)
library(caret)

head(titanic_train)
tail(titanic_train)
glimpse(titanic_train)

## drop NA (Missing Values)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## Split Data
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, size = n * 0.8)
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

## convert data type
train_data$Survived <- as.factor(train_data$Survived)
train_data$Pclass <- as.factor(train_data$Pclass)
train_data$Sex <- as.factor(train_data$Sex)

## train model
log_model <- glm(Survived ~ Pclass + Age + Parch,
    data = train_data,
    family = "binomial")

summary(log_model)

## score
log_predicted <- predict(log_model, 
          newdata = test_data,
          type = "response")
log_predicted_surv <- ifelse(log_predicted >= 0.5 ,1, 0)

## Evaluate
### confusion Matrix
confus <- table(log_predicted_surv, test_data$Survived,
      dnn = c("predicted", "actual"))

## Accuracy
acc <- (confus[1,1] + confus[2,2]) / sum(confus)

## Precision
pre <- confus[2,2] / (confus[2,1] + confus[2,2])

## Recall
rec <- confus[2,2] / (confus[1,2] + confus[2,2])

## F1 Score
f1_score <- 2*((pre * rec) / (pre + rec))
