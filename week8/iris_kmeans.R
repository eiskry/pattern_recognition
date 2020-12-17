source("bisect.R")
data(iris)
petal <- subset(iris,select=c(Petal.Length, Petal.Width))
petal.labels <- c(rep(1,50),rep(2,50),rep(3,50))
petalsc <- scale(petal)
petalsc

km <- kmeans(petalsc, 3)
km
km$centers
table(petal.labels, km$cluster)

plot(petalsc, col=petal.labels+1)
lm13 <- bisect(km$centers[1,],km$centers[3,])
abline(lm13$int,lm13$slop,col="blue")
lm12 <- bisect(km$centers[1,],km$centers[2,])
abline(lm12$int,lm12$slop,col="blue")
points(km$centers,pch=4,cex=2.5,col="black")
