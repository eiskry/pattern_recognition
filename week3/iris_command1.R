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
p
plot(p,xlim=c(2.5,7.5),ylim=c(0.5, 3.0),xlab="length",ylab="width",type="n")
text(p,labels=as.character(class))
