import pandas as pd
import numpy as np
import matplotlib.pylab as plt

from sklearn.cluster import	KMeans
# from scipy.spatial.distance import cdist 

# Kmeans on University Data set 
Data = pd.read_excel(r"C:\Users\UMANG\OneDrive\Desktop\data set kmmeans\Telco_customer_churn (1).xlsx")

Data.isna()
Data.describe()
Data.info()
updatedTelecomData = Data.drop(columns = ["Count","Quarter","Referred a Friend","Number of Referrals","Tenure in Months","Phone Service","Multiple Lines","Internet Service","Internet Type","Avg Monthly GB Download","Online Security","Online Backup","Device Protection Plan","Premium Tech Support","Streaming TV","Streaming Movies","Streaming Music","Unlimited Data","Contract"], axis = 1)

# get dummy var data
listOfCol = ["Offer","Paperless Billing","Payment Method"]
dummyTelecomData = pd.get_dummies(data= updatedTelecomData,columns = listOfCol)


# Normalization function 
def norm_func(i):
    x = (i - i.min())	/ (i.max() - i.min())
    return (x)

# Normalized data frame (considering the numerical part of data)
df_norm = norm_func(dummyTelecomData.iloc[:, 1:])

###### scree plot or elbow curve ############
TWSS = []
k = list(range(1, 19))

for i in k:
    kmeans = KMeans(n_clusters = i)
    kmeans.fit(df_norm)
    TWSS.append(kmeans.inertia_)
    
TWSS
# Scree plot 
plt.plot(k, TWSS, 'ro-');plt.xlabel("No_of_Clusters");plt.ylabel("total_within_SS")

# Selecting 5 clusters from the above scree plot which is the optimum number of clusters 
model = KMeans(n_clusters = 6)
model.fit(df_norm)

model.labels_ # getting the labels of clusters assigned to each row 
mb = pd.Series(model.labels_)  # converting numpy array into pandas series object 
Data['clust'] = mb # creating a  new column and assigning it to new column 

Data.head()
df_norm.head()

