
data <-read_csv("C:\\Users\\UMANG\\OneDrive\\Desktop\\data set kmmeans\\AutoInsurance (1).csv")
#remove 2,3 ,27

dup <- duplicated(data)
dup
data_new <- data[!duplicated(data), ]
data_new

data = select(data, -1)

sum(is.na(data))
attach(data)
as.integer(data,data$`Total Claim Amount`)

#install.packages("dplyr")
#library(dplyr)
#data = select(data, -1, -5:-6)

install.packages("fastDummies")
library(fastDummies) 
install.packages("readr")
library(readr)
library(CatEncoders)

lblState <- LabelEncoder.fit(data$State)
data$State<- transform(lblState,data$State)

lblCoverage <- LabelEncoder.fit(data$Coverage)
data$Coverage<- transform(lblCoverage,data$Coverage)

lblEducation <- LabelEncoder.fit(data$Education)
data$Education<- transform(lblEducation,data$Education)

lblLocationCode <- LabelEncoder.fit(data$`Location Code`)
data$`Location Code`<- transform(lblLocationCode,data$`Location Code`)

lblMarital <- LabelEncoder.fit(data$`Marital Status`)
data$`Marital Status`<- transform(lblMarital,data$`Marital Status`)

lblEmploymentStatus <- LabelEncoder.fit(data$EmploymentStatus)
data$EmploymentStatus<- transform(lblEmploymentStatus,data$EmploymentStatus)

lblPolicytype <- LabelEncoder.fit(data$`Policy Type`)
data$`Policy Type`<- transform(lblPolicytype,data$`Policy Type`)

lblPolicy <- LabelEncoder.fit(data$`Policy`)
data$Policy<- transform(lblPolicy,data$`Policy`)

lblRenewoffertype <- LabelEncoder.fit(data$`Renew Offer Type`)
data$`Renew Offer Type`<- transform(lblRenewoffertype,data$`Renew Offer Type`)

lblSales <- LabelEncoder.fit(data$`Sales Channel`)
data$`Sales Channel`<- transform(lblSales,data$`Sales Channel`)

lblVC <- LabelEncoder.fit(data$`Vehicle Class`)
data$`Vehicle Class`<- transform(lblVC,data$`Vehicle Class`)

lblVS <- LabelEncoder.fit(data$`Vehicle Size`)
data$`Vehicle Size`<- transform(lblVS,data$`Vehicle Size`)

processedInsData <- dummy_cols(data, 
                               select_columns = c("Response","Gender","Effective To Date"), 
                               remove_first_dummy =  TRUE, 
                               remove_most_frequent_dummy = FALSE, 
                               remove_selected_columns = TRUE)

summary(processedInsData)


normalized_data <- scale(processedInsData[, 1:23])

#install.packages("animation")
#library(animation)
nized_data.dropna()ormal
twss <- NULL
for (i in 1:23) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:23, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
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
