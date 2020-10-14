library(MASS)::data()
airquality
mode(airquality$Month) <- "factor"
class(airquality$Month)
pairs(airquality[1:4], pch=21, bg=c("yellow","gray","red", "green3", "blue","cyan")[unclass(airquality$Month)])
