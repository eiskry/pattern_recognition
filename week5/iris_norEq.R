library(MASS)
data(iris)
vv <- subset(iris,iris$Species != "setosa", c(Petal.Length,Petal.Width))
x <- cbind(rep(1,100), vv$Petal.Length, vv$Petal.Width)
x
y <- rep(c(1,-1), rep(50,2))
y


source("filename.R")
normalEq(x,y)

par <- normalEq(x,y)
res <- x%*%par # 識別関数値の計算
res
neg <- res[1:50] # -1 のクラス
neg
pos <- res[51:100] # +1 のクラス
pos
nneg <- neg[neg<0] # -1 のクラスの中で、識別関数値が負のものだけを選択
npos <- pos[pos>0] # +1 のクラスの中で、識別関数値が正のものだけを選択
length(nneg) # 識別関数値が負のものの数
length(npos) # 識別関数値が正のものの数
