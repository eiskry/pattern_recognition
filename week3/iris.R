source("qdaPR.R")

data(iris3)
pl1<-iris3[,3,2] # versicolor の花弁の長さ
pw1<-iris3[,4,2] # versicolor の花弁の幅
pl2<-iris3[,3,3] # virginica の花弁の長さ
pw2<-iris3[,4,3] # virginica の花弁の幅