qdaPR<-function(XY, S, c, F){
  len<-nrow(XY)
  res<-numeric(len)
  for(i in 1:len){
    tmp<-XY[i,]
    res[i]<-t(tmp)%*%S%*%tmp + 2*c%*%tmp + F
  }
  return(res)
}
6
binorm<-function(XY, mean, detS, invS){
  len<-nrow(XY)
  res<-numeric(len)
  coef<-1/(2*pi*sqrt(detS))
  for(i in 1:len){
    tmp<-XY[i,]
    res[i]<-coef*exp(-0.5*t(tmp-mean)%*%invS%*%(tmp-mean))
  }
  return(res)
}