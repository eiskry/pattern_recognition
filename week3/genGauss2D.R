# s1: two-dimensional principal vector
# v1: variances along two axes
# mean: mean vector
genGauss2D<-function( s1, v1, mean, n ){
  s2<-c(s1[2], -s1[1])
  norm<-sqrt(s1[1]*s1[1]+s1[2]*s1[2])
  sn1<-s1/norm
  sn2<-s2/norm
  sigma<-v1[1]*sn1%o%sn1 + v1[2]*sn2%o%sn2
  sc<-t(chol(sigma))
  yy<-matrix( rep(0, 2*n), n, 2)
  for(i in 1:n){
    x<-rnorm(2)
    y<-sc%*%x+mean
    yy[i,]<-y
  }
  return( list(rand=yy,cov=sigma) )
}