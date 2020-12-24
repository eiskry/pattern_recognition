require(xgboost)
require(Matrix)
library(tidyverse)
library(MASS)

#### データの準備
pimaTrain <-  Pima.tr
pimaTest <- Pima.te
yTrain <- pimaTrain[,8]
yTrain
yTrain <- as.integer(yTrain) -1
yTrain
yTest <- pimaTest[,8]
yTest <- as.integer(yTest) -1
yTest
dtrain <- xgb.DMatrix(data=as.matrix(pimaTrain[,1:7]), label=yTrain)
mode(dtrain)
dtest <- xgb.DMatrix(data=as.matrix(pimaTest[,1:7]), label=yTest)

#### モデルの数Mの探索
l_param <- list(booster='gbtree', objective='binary:logistic',
                eval_metric='error', eta=0.1, max_depth=1)
xgb_cv <- xgb.cv(data=dtrain, nrounds=500, nfold=5,
                 params=l_param, early_stopping_rounds = 50, seed=123)
summary(xgb_cv)
head(xgb_cv$evaluation_log)

xgb_cv$evaluation_log %>% ggplot(aes(x=iter)) +
  geom_line(aes(y=train_error_mean, col='train')) +
  geom_line(aes(y=test_error_mean, col='test')) +
  ggtitle("error") + ylab("erroe_mean") + ylim(0,0.4)

#### 最適な繰り返し数を用いた学習
set.seed(123)
irxgb <- xgb.train(data=dtrain, max.depth=1, eta=0.1, nrounds=36,
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
head(pimaTest)
irpred <- predict(irxgb, as.matrix(pimaTest[,1:7]))
head(irpred)
irprediction <- as.numeric(irpred>0.5)
head(irprediction)
table(as.numeric(pimaTest[,8])-1, irprediction)
