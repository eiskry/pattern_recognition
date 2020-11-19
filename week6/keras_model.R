##################### パッケージインストール
library(keras)
library(MASS)

##################### データの準備
sv <- rbind(iris3[,,1], iris3[,,3]) # setosa+virginica
vc <- iris3[,,2] # versicolor

svcl <- c(rep(1,100)) # sv のクラスを1
sv <- cbind(sv,svcl)
vccl <- c(rep(0,50)) # vc のクラスを0
vc <- cbind(vc, vccl)

sv <- as.matrix(sv) # 行列に変換
vc <- as.matrix(vc)
colnames(sv) <- NULL # 列名を削除
colnames(vc) <- NULL
svc <- rbind(sv, vc)


##################### 学習データとテストデータの作成

ind <- sample(1:nrow(svc), nrow(svc)*2/3) # 全体の2/3を学習データに
train.data <- svc[ind, 1:4]
test.data <- svc[-ind, 1:4] # 残りの1/3をテストデータに
train.targets <- svc[ind, 5]
test.targets <- svc[-ind, 5]


##################### モデルの構築

######## モデルオブジェクトの準備
model <- keras_model_sequential()

######## model内部の構造の構築
model %>% 
  layer_dense( units = 8, activation = 'sigmoid', input_shape = c(4)) %>%
  layer_dense( units = 1, activation = 'sigmoid')

######## modelのコンパイル
model %>% 
  compile(loss = 'binary_crossentropy',  # 2クラス問題→2値クロスエントロピー
          optimizer = optimizer_sgd(lr = 0.05), 
          metrics = c('accuracy')
          )

######## モデルの実行
history <- model %>% fit(
  train.data,
  train.targets,
  epochs = 500,
  batch_size = 5,
  validation_split = 0.2
)

######## テストデータによる汎化誤差の評価
score <- model %>% evaluate(test.data, test.targets, batch_size=128)
print(score)

classes <- model %>% predict_classes(test.data, batch_size = 128)


##################### 学習結果の解析
wgts <- get_weights(model)
wgts                                     

layer_outputs <- lapply(model$layers, function(layer) layer$output)
model$layers

layer_outputs


activation_model <- keras_model(inputs = model$input, outputs = layer_outputs)
model$input
activation_model

test <- array_reshape(test.data[1, ], c(1,4))
activations <- activation_model %>% predict(test)
activations

first_layer_activation <- activations[[1]]
barplot(first_layer_activation, names=1:8)
