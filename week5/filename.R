normalEq<-function(x,y){
  xx <- t(x) %*% x
  xxinv <- solve(xx)
  par<- xxinv %*% t(x) %*% y
  plot(x[,c(2,3)], type="n", xlab="X1", ylab="X2") 
  text(x[,c(2,3)],labels=as.character(y)) 
  a <- -par[1]/par[3]
  b <- -par[2]/par[3]
  abline(a,b)
  return(par)
  1
}
