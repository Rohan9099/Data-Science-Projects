
library(caTools)
library(caret)
library(caret)
library(rpart)

data<-read.csv("C:/Users/Hp/Documents/BE_Project/Heart-Disease-Prediction-Using-Machine-Learning-R-and-Shiny--master/data.csv")
View(data)
summary(data)
str(data)

#Test for missing values
sum(is.na(data)) #Total missing values 
sapply(data, function(x) sum(is.na(x))) #Column wise
mean(is.na(data)) #Percentage of values in dataset missing

#Remove rows with missing values
data<-na.omit(data)
sum(is.na(data)) #Confirm removal of missing values
sapply(data, function(x) sum(is.na(x)))

#split the data
temp_field<-sample.split(data,SplitRatio = 0.75)

#keep 75% for training
train<-subset(data,select=c(1,4,5,8,10,12),temp_field==TRUE)
View(train)

#summarizing the property of training data set 
#calculating the dimension of training 
dim(train)

#keep 25% for testinginstall.packages("e1071", dep = TRUE, type = "source")
test<-subset(data,select=c(1,4,5,8,10,12),temp_field==FALSE)
View(test)


#decision tree
library(rpart)
fit <-rpart(train$Age~., data = train, method = "class")
fit <-rpart(train$resting.bp~.,data = train, method = "class" )
fit <-rpart(train$cholestrol~., data = train, method = "class")
fit <-rpart(train$max.heart.rate~., data = train, method = "class")
fit <-rpart(train$oldpeak~., data = train, method = "class")
fit <-rpart(train$ca~., data = train, method = "class")
plot(fit)
text(fit)
preds <- predict(fit, newdata = test[,-14], type="class")
mean(preds == test$Age)
mean(preds == test$resting.bp)
mean(preds == test$cholestrol)
mean(preds == test$max.heart.rate)
mean(preds == test$oldpeak)
mean(preds == test$ca)
output1 <- cbind(test, preds)
View(output1)
output1



