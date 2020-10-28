source("contour.R")

x<-seq(-1,5,0.1)
y<-seq(-2.5,5,0.1)
XY<-matrix(c(rep(x,length(y)),rep(y,each=length(x))),,2)
dist<-binorm(XY,s1,v1,mean)
contour(x,y,matrix(dist,length(x),length(y)),nlevels=10,add=T,lty=3)