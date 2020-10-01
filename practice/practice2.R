x <- "dataset"
typeof(x)
attributes(x)

y <- 1:10
y
typeof(y)
length(y)

z <- as.numeric(y)
typeof(z)
z

character(5)
numeric(5 )
logical(5)

x <- c(1, 2, 3)
x

series <- 1:10
seq(10)
series
seq(from = 1, to = 10, by = 0.1)

x <- c(0.5, NA, 0.7)
x
x <- c(x , 100)
is.na(x)

1/0
0/0

m <- matrix(nrow = 2, ncol = 2)
m
dim(m)
m <- matrix(c(1:3))
class(m)
typeof(m)
m
dim(m)

m <- matrix(1:6, nrow = 2, ncol = 3)
m

n <- 1:10
dim(n) <- c(2, 5)
n

x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)

mdat <-  matrix(c(1, 2, 3, 4, 5, 6),
                nrow = 2,
                ncol = 3,
                byrow = TRUE)
mdat
mdat[2,3]
