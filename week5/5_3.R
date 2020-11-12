data(iris3)
tr <- sample(1:50,25)
train <- rbind(iris3[tr,,1],iris3[tr,,2],iris3[tr,,3])
test <- rbind(iris3[-tr,,1],iris3[-tr,,2],iris3[-tr,,3])
c(rep("s",25),rep("c",25),rep("v",25))
cl <- factor(c(rep("s",25),rep("c",25),rep("v",25)))

ir.lda <- lda(train,cl)

ir.test <- predict(ir.lda,test)
ir.test$class != cl
test[ir.test$class != cl,]

ir.test$x
# plot(ir.test$x, type="n", labels = as.character(ir.test$class))
text(ir.test$x, labels=as.character(cl))

plot(ir.lda, 　dimen=1)

table(cl, ir.test$class)
#####


ir.ldx <- ir.test$x 
ir.ld23 <- tail(ir.ldx, 50)
ir.ld23
ir.sp23 <- tail(cl, 50)
ir.sp23

glmClass23 <- function(x) ifelse(x>0, "v", "c")
ir.sp23~LD1+LD2

ir.glm23 <- glm(ir.sp23~LD1+LD2, family=binomial ,data=as.data.frame(ir.ld23))
ir.glm23
ir.glmpred23 <- predict(ir.glm23)
ir.glmpred23
plot(ir.glmpred23)

ir.glmpred23_ <- predict(ir.glm23,type = "response")
ir.glmpred23_
plot(ir.glmpred23_)


table(ir.sp23, glmClass23(ir.glmpred23))

