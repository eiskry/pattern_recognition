data(iris3)
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
iris.species <- factor(c(rep("s",50), rep("c",50), rep("v",50)))
iris.labels <- c(rep(1,50), rep(2,50), rep(3,50))