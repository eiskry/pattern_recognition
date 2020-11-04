library(MASS)
library(class)
data(iris3)
train<-rbind(iris3[1:25,,2],iris3[1:25,,3])
train <- scale(train)
test<-rbind(iris3[26:50,,2],iris3[26:50,,3])
test <- scale(test)
cl<-factor(c(rep("c",25),rep("v",25))) 

knn3<-knn.cv(train,cl,k=3,prob=TRUE) 
(sum(cl!=knn3))/50 
