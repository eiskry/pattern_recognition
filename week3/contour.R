# XY: 2-D grid
# s1: principal vectors
# v1: variance in two prioncipal directions
# mean: mean vector
binorm<-function(XY, s1, v1, mean)
{
  s2<-c(s1[2], -s1[1])
  norm<-sqrt(s1[1]*s1[1]+s1[2]*s1[2])
  sn1<-s1/norm
  sn2<-s2/norm
  Sigma<-v1[1]*sn1%o%sn1 + v1[2]*sn2%o%sn2
  invS<-solve(Sigma)
  detS<-det(Sigma)
  len<-nrow(XY)
  res<-numeric(len)
  coef<-1/(2*pi*sqrt(detS))
  for(i in 1:len){
    tmp<-XY[i,]
    res[i]<-coef*exp(-0.5*t(tmp-mean) %*% invS %*% (tmp-mean))
  }
  return(res)
}
