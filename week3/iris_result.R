source("qdaPR.R")

data(iris3)

pl1<-iris3[,3,2] # versicolor の花弁の長さ
pw1<-iris3[,4,2] # versicolor の花弁の幅
pl2<-iris3[,3,3] # virginica の花弁の長さ
pw2<-iris3[,4,3] # virginica の花弁の幅

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

cov1<-solve(cov(p1))
cov2<-solve(cov(p2))
x<-seq(2.5,7.0,0.1)
y<-seq(0.5,3.5,0.1)
XY<-matrix(c(rep(x,length(y)),rep(y,each=length(x))),,2)
dist1<-binorm(XY,m1,det(cov(p1)),cov1)
dist2<-binorm(XY,m2,det(cov(p2)),cov2)
contour(x,y,matrix(dist1,length(x),length(y)),nlevels=20,add=T,lty=3)
contour(x,y,matrix(dist2,length(x),length(y)),nlevels=20,add=T,lty=3)

S<-cov1-cov2
c<-m2%*%cov2 - m1%*%cov1
F<-t(m1)%*%cov1%*%m1 - t(m2)%*%cov2%*%m2 + log(det(cov(p1))/det(cov(p2)))
res<-qdaPR(XY,S,c,F)
contour(x,y,matrix(res,length(x),length(y)),levels=0.0,add=T,lty=3)