height <- c(190,189,188,188,187,186,185,185,184,183)
weight <- c(90,87,89,87,89,85,84,83,84,83)
chest <- c(93,92,93,94,92,91,92,93,92,94)
plot(height,weight,xlim=c(182,191),ylim=c(82,91))
plot(weight,chest,xlim=c(82,91),ylim=c(90,95))
students <- cbind(height,weight,chest)
students
st.pr <- prcomp(students)
st.pr
summary(st.pr)

st.pre <- predict(st.pr)
st.pre
library(MASS)
eqscplot(st.pre[,1:2])
eqscplot(st.pre[,2:3])
