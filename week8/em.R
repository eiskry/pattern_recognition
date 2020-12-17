library(mclust)
data(iris)
petal <- subset(iris,select=c(Petal.Length, Petal.Width))
petal
petal.labels <- c(rep(1,50),rep(2,50),rep(3,50))
petal.labels
iris[,3:4]

irEM <- Mclust(iris[,3:4])
irEM
plot(irEM)
names(irEM)
irEM$classification
table(petal.labels, irEM$classification)
