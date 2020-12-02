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


# xdata <- data.frame(ir.train)
# xdata
# xdata$species <- as.factor(data$species)
# xdata

model <- svm(species~., data=ir.train, kernel="polynomial", degree=1, coef0=1, cost=1)

pred <-predict(model,ir.train)
pred

###### 1
table(ir.train$species,predict(model,ir.train))

##### 2
summary(model)

##### 3
table(ir.test$species,predict(model,ir.test))

##### 4
model <- svm(species~., data=ir.train, kernel="polynomial", degree=1, coef0=1, cost=1)

