library(e1071)
library(MASS)

ir<-data.frame(rbind(iris3[,,1],iris3[,,2],iris3[,,3]),
                 species=factor(c(rep("sv",50),rep("c",50),rep("sv",50))))
ir
samp<-c(sample(1:50,25),sample(51:100,25),sample(101:150,25))
samp
ir.train <- ir[samp,]
ir.train
ir.test <- ir[-samp,]
ir.test

model <- 
  svm(species~., data=ir.train, kernel="polynomial", degree=1, coef0=1, cost=1)

pred <-predict(model,ir.train)
pred

###### 1
table(ir.train$species,predict(model,ir.train))

##### 2
summary(model)

##### 3
table(ir.test$species,predict(model,ir.test))

##### 4
model2 <- 
  svm(species~., data=ir.train, kernel="polynomial", degree=3, coef0=1, cost=1)

table(ir.train$species,predict(model2,ir.train))

##### 5
summary(model2)

##### 6
table(ir.test$species,predict(model2,ir.test))

##### 7
model3 <- 
  svm(species~., data=ir.train, kernel="polynomial", degree=2, coef0=1, cost=10)

table(ir.train$species,predict(model3,ir.train))

##### 8
summary(model3)

##### 9
table(ir.test$species,predict(model3,ir.test))


