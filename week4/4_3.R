library(MASS)
library(class)
data(iris3)
train<-rbind(iris3[1:25,,2],iris3[1:25,,3])
train
test<-rbind(iris3[26:50,,2],iris3[26:50,,3])
test
cl<-factor(c(rep("c",25),rep("v",25)))  
#訓練データの正しいクラスラベルを順にベクトルデータとして与え、
#クラスデータとして利用できるようにする。

knn3<-knn.cv(train,test,cl,k=11,prob=TRUE) 
# 各引数の意味を、helpで調べること。

a<-c(1:50)[attributes(knn3)$prob==0.5]
a

length(c(1:50)[cl[-a]!=knn3[-a]])

table(cl,knn3) 
#テストデータの混同行列を作成する。cl にはテストデータの正解を
#factor を用いて作成する。この例では、テストデータの数が学習データの
#数と同じなので、同じcl を流用している。


(sum(cl!=knn3))/50 
# cl!=knn3 でテストデータの正解と計算結果の比較を行い、
#異なっているところにTRUE が、合っているところにFALSE がたつ。
#sum(cl!=knn3) は異なっている数を返す。