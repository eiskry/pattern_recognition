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

#############################

modelsvm=svm(species~.,data=ir.train,type="C",kernel="radial",
            gamma=0.1, cost=100)

pred <-predict(modelsvm,ir.train)

###### 1
table(ir.train$species,predict(modelsvm,ir.train))

##### 2
summary(modelsvm)

##### 3
table(ir.test$species,predict(modelsvm,ir.test))


#############################

modelsvm2=svm(species~.,data=ir.train,type="C",kernel="radial",
             gamma=1, cost=1)

pred <-predict(modelsvm2,ir.train)

###### 1
table(ir.train$species,predict(modelsvm2,ir.train))

##### 2
summary(modelsvm2)

##### 3
table(ir.test$species,predict(modelsvm2,ir.test))



#############################

modelsvm3=svm(species~.,data=ir.train,type="C",kernel="radial",
              gamma=10, cost=1)

pred <-predict(modelsvm3,ir.train)

###### 1
table(ir.train$species,predict(modelsvm3,ir.train))

##### 2
summary(modelsvm3)

##### 3
table(ir.test$species,predict(modelsvm3,ir.test))
