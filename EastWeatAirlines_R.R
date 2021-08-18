library(readxl)
data <-read_excel("C:\\Users\\UMANG\\OneDrive\\Desktop\\data set kmmeans\\EastWestAirlines (1).xls", sheet=2)

sum(is.na(data))

install.packages("dplyr")
library(dplyr)
data = select(data, -1, -5:-6)

normalized_data <- scale(data[, 1:9])

install.packages("animation")
library(animation)

twss <- NULL
for (i in 1:9) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:9, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")

fit <- kmeans(normalized_data, 9) 
str(fit)
fit$cluster
final <- data.frame(fit$cluster, data)

aggregate(data[, 1:9], by = list(fit$cluster), FUN = mean)

