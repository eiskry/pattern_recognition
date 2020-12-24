require(xgboost)
require(Matrix)
library(tidyverse)

#### データの準備
ir <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
                 species=factor(c(rep("sv",50), rep("c", 50), rep("sv", 50))))
ir
ind <- sample(1:nrow(ir), nrow(ir)*2/3)
irTrain2 <- ir[ind,]
irTrain2
irTest2 <- ir[-ind,]
yTrain2 <- irTrain2[,5]
yTrain2 <- as.integer(yTrain2) - 1
yTest2<- irTest2[,5]
yTest2 <- as.integer(yTest2) - 1
dtrain2 <- xgb.DMatrix(data=as.matrix(irTrain2[,1:4]), label=yTrain2)
mode(dtrain2)
dtest2 <- xgb.DMatrix(data=as.matrix(irTest[,1:4]), label=yTest)

#### モデルの数Mの探索
l_param <- list(booster='gbtree', objective='binary:logistic',
                eval_metric='error', eta=0.1, max_depth=1)
xgb_cv <- xgb.cv(data=dtrain, nrounds=100, nfold=5,
                 params=l_param, early_stopping_rounds = 50, seed=123)
summary(xgb_cv)
head(xgb_cv$evaluation_log)

xgb_cv$evaluation_log %>% ggplot(aes(x=iter)) +
  geom_line(aes(y=train_error_mean, col='train')) +
  geom_line(aes(y=test_error_mean, col='test')) +
  ggtitle("error") + ylab("erroe_mean") + ylim(0,0.4)

#### 最適な繰り返し数を用いた学習
set.seed(123)
watchlist <-  list(train = dtrain, eval = dtest)
irxgb <- xgb.train(data=dtrain, max.depth=1, eta=0.1, nrounds=13,
                   watchlist = watchlist, objective="binary:logistic")
summary(irxgb)

#### 学習曲線
head(irxgb$evaluation_log)
irxgb$evaluation_log %>% ggplot(aes(x=iter)) +
  geom_line(aes(y=train_error, col='train')) +
  geom_line(aes(y=eval_error, col='test')) +
  ggtitle("irxgb error") + ylab("error") + ylim(0,0.4)

#### 決定木の出力
set.seed(123)
irxgb_3 <- xgb.train(data=dtrain, max.depth=1, eta=0.1,
                       nrounds=3, watchlist = watchlist, objective="binary:logistic")
xgb.model.dt.tree(colnames(irTrain), model=irxgb_3)
library(DiagrammeR)
xgb.plot.tree(model=irxgb_3)

#### 特徴の重要度
ir_importance <- xgb.importance(model=irxgb)
print(ir_importance)
xgb.plot.importance(importance_matrix = ir_importance)

#### テストデータによる混同行列の計算
head(irTest)
irpred <- predict(irxgb, as.matrix(irTest[,1:4]))
head(irpred)
irprediction <- as.numeric(irpred>0.5)
head(irprediction)
table(as.numeric(irTest[,5])-1, irprediction)
