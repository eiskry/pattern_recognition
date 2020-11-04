library(MASS)
library(class)
data(iris3)
train<-rbind(iris3[1:25,,2],iris3[1:25,,3])
train <- scale(train)
test<-rbind(iris3[26:50,,2],iris3[26:50,,3])
test <- scale(test)
cl<-factor(c(rep("c",25),rep("v",25)))  
knn3<-knn(train,test,cl,k=3,prob=TRUE) 

a<-c(1:50)[attributes(knn3)$prob==0.5]
a
length(c(1:50)[cl[-a]!=knn3[-a]])

table(cl,knn3) 

(sum(cl!=knn3))/50 
