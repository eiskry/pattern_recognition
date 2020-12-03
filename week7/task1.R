library(e1071)
library(MASS)

x1 <- c(0, 0, 1, 1)
x2 <- c(0, 1, 0, 1)
y <- c("-1","1","1","-1")

xor <- data.frame(X1 = x1, X2 = x2, classes = y)
xor$classes <- as.factor(xor$classes)
xor

model1 <- 
  svm(classes~., data=xor, kernel="polynomial", degree=1, coef0=1, cost=1)

pred1<-predict(model1,xor)
pred1
table(xor$classes,predict(model1,xor))

plot(model1,xor,xlim=c(-0.1,1.1),ylim=c(-0.1,1.1))

summary(model1)

pred1
