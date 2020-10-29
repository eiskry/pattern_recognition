x <- runif(100)
y <- runif(100)
plot(x,y,xlim=c(0,1),ylim=c(0,1),col=ifelse(y>0.5,2,4),pch=ifelse(x>0.5,1,17))

x <- runif(100, min = 2, max = 4)
y <- runif(100, min = 3, max = 7)
plot(x,y,xlim=c(2,4),ylim=c(3,7),col=ifelse(y>5,2,4),pch=ifelse(x>3,1,17))
