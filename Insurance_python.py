import pandas as pd
import numpy as np
import matplotlib.pylab as plt

from sklearn.cluster import	KMeans
# from scipy.spatial.distance import cdist 

# Kmeans on University Data set 
Data = pd.read_csv(r"C:\Users\UMANG\OneDrive\Desktop\data set kmmeans\Insurance Dataset.csv")

Data.describe()
data = Data.dropna()
#data = Data.drop(["name"], axis = 1)

# Normalization function 
def norm_func(i):
    x = (i - i.min())	/ (i.max() - i.min())
    return (x)

# Normalized data frame (considering the numerical part of data)
df_norm = norm_func(data.iloc[:, :])

###### scree plot or elbow curve ############
TWSS = []
k = list(range(1, 6))

for i in k:
    kmeans = KMeans(n_clusters = i)
    kmeans.fit(df_norm)
    TWSS.append(kmeans.inertia_)
    
TWSS
# Scree plot 
plt.plot(k, TWSS, 'ro-');plt.xlabel("No_of_Clusters");plt.ylabel("total_within_SS")

# Selecting 5 clusters from the above scree plot which is the optimum number of clusters 
model = KMeans(n_clusters = 2)
model.fit(df_norm)

model.labels_ # getting the labels of clusters assigned to each row 
mb = pd.Series(model.labels_)  # converting numpy array into pandas series object 
data['clust'] = mb # creating a  new column and assigning it to new column 

data.head()
df_norm.head()

data = data.iloc[:,[5,0,1,2,3,4]]
data.head()

data.iloc[:, 1:5].groupby(data.clust).mean()

data.to_csv("Kmeans_university.csv", encoding = "utf-8")

import os
os.getcwd()
