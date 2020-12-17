data(iris3)
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
iris.species <- factor(c(rep("s",50), rep("c",50), rep("v",50)))
iris.species
iris.labels <- c(rep(1,50), rep(2,50), rep(3,50))
iris.labels
ir
ir.pr <- prcomp(ir)
ir.pr
summary(ir.pr)

ir.pre <- predict(ir.pr)
ir.pre
library(MASS)
eqscplot((ir.pre[,1:2]),pch = c("1", "2", "3")[unclass(iris.labels)], col = c("red", "green3", "blue")[unclass(iris.species)],
         xlab = "PC1", ylab = "PC2")

