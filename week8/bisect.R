bisect<-function(p1,p2){
  p <- (p1+p2)/2
  n1 <- (p1-p2)
  n <- n1/(sqrt(n1[1]*n1[1]+n1[2]*n1[2]))
  b <- -n[1]/n[2]
  a <- n[1]/n[2]*p[1]+p[2]
  2
  return( list(int=a,slop=b) )
}