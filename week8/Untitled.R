x1 <- c(1,3)
x2 <- c(4,1)
x3 <- c(5,1)
x4 <- c(5,4)
x5 <- c(7,3)
d1 <- rbind(x1,x2,x3,x4,x5)
d1
plot(d1,xlim=c(0,8),ylim=c(0,5))

d1.sing <- hclust(dist(d1),method="single") 
plclust(d1.sing)
cutree(d1.sing,2) 
