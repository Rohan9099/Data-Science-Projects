#PART ONE:DATA PREPARATION 
#Load dataset
data<-read.csv("C:/Users/Hp/Documents/NFU/DMW/HREmployeeAttrition.csv")

#Inspect structure of data 
head(data)
str(data)

#Test for missing values
sum(is.na(data)) #Total missing values 
sapply(data, function(x) sum(is.na(x))) #Column wise
mean(is.na(data)) #Percentage of values in dataset missing

#Remove rows with missing values
data<-na.omit(data)
sum(is.na(data)) #Confirm removal of missing values
sapply(data, function(x) sum(is.na(x)))

#Remove customer ID column
data[1]<-NULL
str(data) #Confirm removal

#Split dataset into train and test data
library(caTools)
set.seed(123) #Ensures the same random numbers are always generated 
sample = sample.split(data,SplitRatio = 0.75) 
train =subset(data,sample ==TRUE) 
test=subset(data, sample==FALSE)
str(train)

#PART TWO:MODEL APPLICATION
#(1) RANDOM FOREST
#Fit model
library(randomForest)
rf <- randomForest(Attrition ~ ., data = train)
predicted_rf<-predict(rf,test)

#Prediction results
table(predicted_rf) #Tabulate data

#Visualize results
plot(rf, main="randomForest model")
plot(predicted_rf,test$Attrition, main="Predicted Vs. Actual - Random Forest", ylab="Predicted",xlab="Actual")
varImpPlot(rf,sort=TRUE,main = "Varable Importance Plot - randomForest")

#Evaluate performance of model
library (caret) # Run confusion Matrix
confusionMatrix(predicted_rf,test$Attrition) #Accuracy = 79.81%
output1 <- confusionMatrix(predicted_rf, test$Attrition, mode="prec_recall")

output1
output1$byClass["Precision"]
output1$byClass["Recall"]

#(2)NAIVE BAYES
#Fit model
library(e1071)
nb<-naiveBayes(Attrition ~ ., data = train)
predicted_nb= predict(nb,test)
       
#Prediction results
table(predicted_nb) #Tabulate data

#Visualize results
plot(predicted_nb, test$Attrition, main="Predicted Vs. Actual - Naive Bayes", ylab="Predicted",xlab="Actual")

#Evaluate performance of model
confusionMatrix(predicted_nb,test$Attrition) #Accuracy: 73.83%


output2 <- confusionMatrix(predicted_nb, test$Attrition, mode="prec_recall")

output2
output2$byClass["Precision"]
output2$byClass["Recall"]

#Prediction Accuracy 
#RandomForest - 85 %
#Naive Bayes - 79 %
#Decision Tree - 85 %
