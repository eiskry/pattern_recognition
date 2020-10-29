source("qdaPR.R")

data(iris3)

pl1<-iris3[,3,2] # versicolor の花弁の長さ
pw1<-iris3[,4,2] # versicolor の花弁の幅
pl2<-iris3[,3,3] # virginica の花弁の長さ
pw2<-iris3[,4,3] # virginica の花弁の幅

# h1<-c(190,189,188,188,187)
# w1<-c(90,87,89,87,89)
# h2<-c(186,185,185,184,183)
# w2<-c(85,84,83,84,83)

# class<-c(rep(1,5),rep(2,5))

class<-c(rep("c",50),rep("v",50))

mh1<-mean(pl1)
mw1<-mean(pw1)
m1<-c(mh1, mw1)
mh2<-mean(pl2)
mw2<-mean(pw2)
m2<-c(mh2, mw2)
p1<-cbind(pl1,pw1)
p2<-cbind(pl2,pw2)
p<-rbind(p1,p2)
# plot(p,xlim=c(2.5,7.5),ykim=c(0.5, 3.5),xlab="length",ylab="width",type="n")
# text(p,labels=as.character(class))


cov1<-solve(cov(p1))
cov2<-solve(cov(p2))
x<-seq(2.5,7.5,0.1)
y<-seq(0.8,3.0,0.1)
XY<-matrix(c(rep(x,length(y)),rep(y,each=length(x))),,2)
dist1<-binorm(XY,m1,det(cov(p1)),cov1)
dist2<-binorm(XY,m2,det(cov(p2)),cov2)
contour(x,y,matrix(dist1,length(x),length(y)),nlevels=20,add=T,lty=3)
contour(x,y,matrix(dist2,length(x),length(y)),nlevels=20,add=T,lty=3)