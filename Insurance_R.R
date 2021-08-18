library(readcs)
data <-read.csv("C:\\Users\\UMANG\\OneDrive\\Desktop\\data set kmmeans\\Insurance Dataset.csv")


sum(is.na(data))

#install.packages("dplyr")
#library(dplyr)
#data = select(data, -1, -5:-6)

normalized_data <- scale(data[, 1:5])

#install.packages("animation")
#library(animation)

twss <- NULL
for (i in 1:5) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:5, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")

fit <- kmeans(normalized_data, 4) 
str(fit)
fit$cluster

final <- data.frame(fit$cluster, data)
aggregate(data[, 1:5], by = list(fit$cluster), FUN = mean)


#library(dplyr)
#mydata = select(data, -1)

install.packages("animation")
library(animation)

km <- kmeans.ani(data, 4)
km$centers

# kmeans clustering
km <- kmeans(data, 4) 
str(km)
