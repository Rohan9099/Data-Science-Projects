library(caret)
library(caTools)
data<-read.csv("C:/Users/Hp/Documents/BE_Project/Heart-Disease-Prediction-Using-Machine-Learning-R-and-Shiny--master/data.csv")
View(data)
summary(data)
str(data)
head(data)

train <- createDataPartition(y = data$num, p= 0.7, list = FALSE)
training <- data[train,]
testing <- data[-train,]

dim(training); 
dim(testing);

anyNA(data)
training[["num"]] = factor(training[["num"]])

trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

svm_Linear <- train(num ~., data = training, method = "svmLinear",
                    trControl=trctrl,
                    preProcess = c("center", "scale"),
                    tuneLength = 10)

test_pred <- predict(svm_Linear, newdata = testing)
test_pred

                