library(readxl)
data <-read_excel("C:\\Users\\UMANG\\OneDrive\\Desktop\\data set kmmeans\\Telco_customer_churn (1).xlsx")
#remove 2,3 ,27
data = select(data, -1,-2, -3,-27)

sum(is.na(data))

#install.packages("dplyr")
#library(dplyr)
#data = select(data, -1, -5:-6)

install.packages("fastDummies")
library(fastDummies) 
install.packages("readr")
library(readr)
library(CatEncoders)

lblOffer <- LabelEncoder.fit(data$Offer)
data$Offer<- transform(lblOffer,data$Offer)

lblIT <- LabelEncoder.fit(data$`Internet Type`)
data$`Internet Type`<- transform(lblIT,data$`Internet Type`)

lblPM <- LabelEncoder.fit(data$`Payment Method`)
data$`Payment Method`<- transform(lblPM,data$`Payment Method`)

lblCt <- LabelEncoder.fit(data$Contract)
data$Contract<- transform(lblCt,data$Contract)

processedInsData <- dummy_cols(data, 
                               select_columns = c("Referred a Friend","Phone Service","Multiple Lines","Internet Service","Online Security","Online Backup","Device Protection Plan","Premium Tech Support","Streaming TV","Streaming Movies","Streaming Music","Unlimited Data","Paperless Billing"), 
                               remove_first_dummy =  TRUE, 
                               remove_most_frequent_dummy = FALSE, 
                               remove_selected_columns = TRUE)

summary(processedInsData)


normalized_data <- scale(processedInsData[, 1:26])

#install.packages("animation")
#library(animation)
nized_data.dropna()ormal
twss <- NULL
for (i in 1:26) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:26, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")

fit <- kmeans(normalized_data, 10) 
str(fit)
fit$cluster

final <- data.frame(fit$cluster, data)
aggregate(data[, 1:26], by = list(fit$cluster), FUN = mean)


#library(dplyr)
#mydata = select(data, -1)

install.packages("animation")
library(animation)

km <- kmeans.ani(normalized_data, 10)
km$centers

# kmeans clustering
km <- kmeans(data, 4) 
str(km)
