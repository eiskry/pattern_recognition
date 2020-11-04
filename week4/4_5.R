library(MASS)
library(class)
data(iris3)
train<-rbind(iris3[1:25,,2],iris3[1:25,,3])
train <- scale(train)
test<-rbind(iris3[26:50,,2],iris3[26:50,,3])
test <- scale(test)
cl<-factor(c(rep("c",25),rep("v",25)))  

x <- list()
k_list <- list()
for (i in 1:25){
  k <- 2*i -1
  k_list <- c(k_list,list(2*i -1))
  knn_k <- knn.cv(train,cl,k,prob=TRUE) 
  x <- c(x,list((sum(cl!=knn_k))/50 ))
}
x
k_list
plot(k_list,x)
