library(MASS)::data()
iris
iris$Species
attach(iris)
Species
detach(iris)
class(iris)
class(iris$Sepal.Length)
class(iris$Sepal.Width)
class(iris$Species)

c("a","b","c")[unclass(iris$Species)]

pairs(iris[1:4], pch=21, bg=c("red", "green3", "blue")[unclass(iris$Species)])
iris$Species

pairs(iris, pch=21, bg=c("red", "green3", "blue")[unclass(iris$Species)])
