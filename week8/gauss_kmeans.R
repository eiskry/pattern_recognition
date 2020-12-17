source("bisect.R")
library(MASS)
library(mvtnorm)

# class1
# 平均値:x=25, y=35 共分散行列
Mu1 <- c(25,35)
sigma1 <- matrix(c(25, 28, 28, 49), ncol=2)
class1 = rmvnorm(n = 50,Mu1, sigma1)
class1

# class2
# 平均値:x=15, y=45 共分散行列
Mu2 <- c(15,45)
sigma2 <- matrix(c(9, 24, 24, 36), ncol=2)
class2 = rmvnorm(n = 50,Mu2, sigma2)
class2

# class3
# 平均値:x=20, y=30 共分散行列
Mu3 <- c(20,30)
sigma3 <- matrix(c(25, 26, 26, 16), ncol=2)
class3 = rmvnorm(n = 50,Mu3, sigma3)
class3

data = rbind(class1, class2, class3)
data
data.labels <- c(rep(1,50),rep(2,50),rep(3,50))
data
