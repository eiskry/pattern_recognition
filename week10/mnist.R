library(keras)
mnist <- dataset_mnist()
mnist
str(mnist)
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

#### データの整形
dim(x_train)
dim(x_test)
#######データフォーマットを合わせる
x_train <- array_reshape(x_train, c(nrow(x_train), 28, 28, 1))
dim(x_train)
x_test <- array_reshape(x_test, c(nrow(x_test), 28, 28, 1))
dim(x_test)
####### 画素値を整数値から0と1の間の実数に変換する
max(x_train)
min(x_train)
max(x_test)
min(x_test)
x_train <- x_train / 255
x_test <- x_test / 255
####### 教師データをone-hot codingに変える
y_train[1]
y_train <- to_categorical(y_train, 10)
dim(y_train)
y_train[1,]
y_test <- to_categorical(y_test, 10)
dim(y_test)
y_test[1,]

######モデルの構築
######## モデルオブジェクトの準備
modelCNN <- keras_model_sequential()
######## model内部構造の定義
input_shape = c(28,28,1)
modelCNN <- keras_model_sequential() %>%
  layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = 'relu',
                input_shape = input_shape) %>%
  layer_conv_2d(filters = 64, kernel_size = c(3,3), activation = 'relu') %>%
  layer_max_pooling_2d(pool_size = c(2, 2)) %>%
  layer_dropout(rate = 0.25) %>%
  layer_flatten() %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(units = 10, activation = 'softmax')
summary(modelCNN)
####### モデルのコンパイル
modelCNN %>% compile(
  loss = loss_categorical_crossentropy,
  optimizer = optimizer_adam(),
  metrics = c('accuracy')
)
####### モデルの実行
# train model
history <- modelCNN %>% fit(
  x_train, y_train,
  batch_size = 128,
  epochs = 12,
  validation_split = 0.2
)

########　テストデータによる汎化誤差の評価
score <- modelCNN %>% evaluate(x_test, y_test, batch_size=128)
print(score)
classes <- modelCNN %>% predict_classes(x_test, batch_size=128)
test_label <- mnist$test$y
table(test_label, classes)

# modelCNN %>% save_model_hdf5(``mnistCNN3x3.h5'')
# modelCNN <- load_model_hdf5(``mnistCNN3x3.h5'')

#### 学習結果の解析
#####　モデルの各層の出力の抽出
layer_outputs <- lapply(modelCNN$layers, function(layer) layer$output)
modelCNN$layers
layer_outputs

#### ある入力に対する出力を計算するモデルを定義する
activation_model <- keras_model(inputs=modelCNN$input, outputs=layer_outputs)
modelCNN$input
activation_model 　# この出力を確認しておくこと

####入力データを用意する
test <- array_reshape(x_train[3,,,1], c(1,28,28,1))
activations <- activation_model %>% predict(test)
#activations をそのまま出力すると、モデルの全ての素子の出力が表示されるので注意すること
str(activations) 　
activations
last_layer_activation = activations[[8]]
last_layer_activation
barplot(last_layer_activation, names = 0:9)
six_layer_activation = activations[[6]]
seven_layer_activation = activations[[7]]
identical(six_layer_activation,seven_layer_activation)

###############
#### チャンネル画像の表示
plot_channel <- function(channel){
   channel <- channel /(max(channel)- min(channel) + 1e-5) #出力を[0, 1] にする
   plot(as.raster(channel))
}

image_size <- 58 　　#　描画する画像のサイズ
image_per_row <- 16 　#　1 行に描画する画像の枚数

for(i in 1:4) {
  layer_activation <- activations[[i]]
  layer_name <- modelCNN$layers[[i]]$name
  n_features <- modelCNN$layers[[i]]$output_shape[[4]]
  n_cols <- n_features %/% image_per_row
  png( paste0("mnist_activations_3x3_",i,"_",layer_name, ".png"),
       width= image_size*image_per_row,
       height= image_size*n_cols )
  op <- par(mfrow = c(n_cols, image_per_row), mai = rep_len(0.02, 4))
  for(col in 0:(n_cols-1)) {
    for(row in 0:(image_per_row-1)){
      channel_image <- layer_activation[1,,,(col*image_per_row)+row+1]
      plot_channel(channel_image)
    }
  }
  par(op)
  dev.off()
}
