library(MASS)
library(mvtnorm)

# class1
# 平均値:x=25, y=35 
# 標準偏差：x=5, y=7
# 相関係数：0.8
Mu1 <- c(25,35)
sigma1 <- matrix(c(25, 28, 28, 49), ncol=2)
class1 = rmvnorm(n = 50,Mu1, sigma1)

# class2
# 平均値:x=45, y=15
# 標準偏差：x=6, y=8
# 相関係数：0.5
Mu2 <- c(45,15)
sigma2 <- matrix(c(36, 24, 24, 64), ncol=2)
class2 = rmvnorm(n = 50,Mu2, sigma2)

# class3
# 平均値:x=20, y=30
# 標準偏差：x=3, y=6
# 相関係数：0.4
Mu3 <- c(20,30)
sigma3 <- matrix(c(9, 7.2, 7.2, 36), ncol=2)
class3 = rmvnorm(n = 50,Mu3, sigma3)

data = rbind(class1, class2, class3)
data.labels <- c(rep(1,50),rep(2,50),rep(3,50))

datasc <- scale(data)
datasc

irEM2 <- Mclust(datasc)
irEM2
plot(irEM2)
names(irEM2)
irEM2$classification
table(data.labels, irEM2$classification)
