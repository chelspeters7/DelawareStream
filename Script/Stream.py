import pandas as pd
import csv
import matplotlib.pyplot as plt
plt.style.use('seaborn-whitegrid')
import numpy as np

#%%
files = ['Data/01484080.csv']
series = pd.read_csv('Data/01484080.csv',
                             parse_dates = ['Datetime'],
                             index_col = ['Datetime'])

series.dtypes

# create the plot space upon which to plot the data
plt.style.use('seaborn-whitegrid')
fig, ax = plt.subplots(3,1, sharex='col')

p = [series['Discharge'],series['Temperature'],series['Specific_conductance']]

for i in range(3):
    ax[i].plot(series.index.values, p[i])

fig.savefig("Figures/DisAndSC.png")    
plt.show()















