x1 <- c(1,0,1)
x2 <- c(1,1,0)
x3 <- c(1,1,1)
y <- c(-1,-1,1) # 教師データ
x <- rbind(x1,x2,x3) # データ行列


source("filename.R")
normalEq(x,y)

par <- normalEq(x,y)
res <- x%*%par # 識別関数値の計算
res
neg <- res[1:2] # -1 のクラス
pos <- res[3] # +1 のクラス
nneg <- neg[neg<0] # -1 のクラスの中で、識別関数値が負のものだけを選択
npos <- pos[pos>0] # +1 のクラスの中で、識別関数値が正のものだけを選択
length(nneg) # 識別関数値が負のものの数
length(npos) # 識別関数値が正のものの数
