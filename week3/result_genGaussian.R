library(MASS)
source("genGauss2D.R")

#s1<-c(2, 5)
#v1<-c(2.0, 0.5)
#mean<-c(2,1)

s1<-c(3, 9)
v1<-c(4.0, 0.5)
mean<-c(4,2)

x1<-genGauss2D(s1, v1, mean, 100)
eqscplot(x1$rand[,1],x1$rand[,2])

cov(x1$rand)
apply(x1$rand,2,mean)
x1$cov