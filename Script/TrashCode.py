def main():
    # read file
        filenam = open('Data/test.txt', 'r')
        lines = filenam.readlines()
        filenam.close

        #look for patterns
        header = []
        data = []
        for line in lines:
                line = line.strip().upper()
                if line.find('#') == -1:
                        if line.find("AGENCY") != -1:
                                header = line.split('\t')
                        if line.find("USGS") != -1:
                                data = line.split('\t')
                                print(data)
main()


#%%

# create the plot space upon which to plot the data
fig, ax= plt.subplots()

# add the x-axis and the y-axis to the plot
ax.plot(series.index.values, 
        series['Discharge'])

# rotate tick labels
plt.setp(ax.get_xticklabels(), rotation=45)

# set title and labels for axes
ax.set(xlabel="Date",
       ylabel="Discharge (ft3/s)",
       title="Discharge\nUSGS 01484080 MURDERKILL RIVER FREDERICA, DE")

# save figure
fig.savefig("Figures/Discharge.png")
plt.show()


datetime = []
sc = []
tstart = []
tend = [] 
tstep = []
tseries = []

f = pd.read_csv('Data/01484080.csv')
datetime.append(f['Datetime'])
sc.append(f['Specific_conductance'])
sc = np.array(sc)
tstart = np.datetime64('2019-04-01T00:00')#np.arange(1, ,1)
tend = np.datetime64('2019-05-14T16:06') 
tstep = np.timedelta64(6, 's')
tseries = np.arange(tstart, tend, tstep)






fig, ax = plt.subplots()
ax.plot(, sc)

ax.set(xlabel='Datetime', ylabel='Specific Conductivity ()',
       title='About as simple as it gets, folks')
ax.grid()

fig.savefig("Figures/SC.png")
plt.show()

#%%
with open('01484000.txt', 'r') as f:
    for line in f:
        if line.startswith("#") : 
            continue
        print(line)
        #x = f.readlines()


import csv

datetime = []
sc = []

for f in csv.DictReader(open('Data/01484080.csv')):
    datetime.append(f['Datetime'])
    sc.append(f['Specific_conductance'])
    
print('Salinity = ', sc)
#print('Date = ', datetime)


with open('01484080.csv', 'r') as f:
    reader = csv.reader(f)

    rownum = 0
    for row in reader:
        if rownum == 0:
            header = row
            print(header)
        else:
            colnum = 0
            for col in row:
                print(header[colnum], col)
                colnum = colnum + 1
 
        rownum = rownum + 1