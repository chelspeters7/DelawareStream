#%%
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import pyplot, dates
import time
#plt.style.use('seaborn-whitegrid')

def _my_dt_to_float_ordinal(dt):
    try:
        base = dates.epoch2num(dt.astype(int64) / 1.0E9)
    except AttributeError:
        base = dates.date2num(dt)
    return base
pandas.tseries.converter._dt_to_float_ordinal =_my_dt_to_float_ordinal
#==================================
def PlotDischarge(df, sitenum):
    fig, ax = plt.subplots(figsize =(20,10))
    findJan1 = df[df['Date'].str.contains("-01-01 00:0")].index
    correctcol = df['Date']
    longdates = correctcol[findJan1].values
    x_axis = list(map(datetime.datetime.strptime, longdates, 
             len(longdates)*['%Y-%m-%d %H:%M']))

    fig.canvas.draw()
    plt.xticks(abc.values)
    year = []
    for i in x_axis:
        year.append(i.strftime('%Y'))
    ax.set_xticklabels(year)
    ax.plot(df.index,df['Discharge'])

    plt.setp(ax.get_xticklabels(), rotation=45)
    ax.set_xlabel("Date", fontsize=25)
    ax.set_ylabel("Discharge (ft\u00b3/s)", fontsize=25)
    ax.set_title("Discharge\nUSGS Site 0{}".format(sitenum), 
                fontsize=30)
    ax.tick_params(axis='both', which='major', labelsize=20)

    filenamesave = 'Discharge0{}.png'.format(sitenum)
    fig.savefig(filenamesave)
    plt.show()
#%%
#===========================================
filename = 'Data/01484080.txt'
sitenum = 1484080
data = pd.read_csv(filename, sep='\t', 
        parse_dates=['datetime'],
        comment='#',
        usecols=['site_no','datetime','165652_00065',
        '213117_72137','69417_00010','69418_00095',
        '69419_00400','69420_00300','69421_72255',
        '69422_00060'])

data.columns = ['Site','Date', 'GageHeight',
        'DischargeFiltered','Temperature',
        'SpecificConductivity','pH','DO','MeanVelocity',
        'Discharge']
data.loc[0] = 'NaN'
startdata = data['Date'][data.index[1]]
enddata = data['Date'][data.index[-1]]

df = pd.DataFrame(data=data)

headerss = ['Site','GageHeight','DischargeFiltered',
        'Temperature','SpecificConductivity','pH','DO',
        'MeanVelocity','Discharge']
for i in headerss:
        df[i] = df[i].astype('float')

#df['Date'] = pd.to_datetime(df['Date'],format='%Y-%m-%d %H:%M')
#df.info()
#df.dtypes

PlotDischarge(df, sitenum)

#%%
#===========================================
filename = 'Data/01484000.txt'
sitenum = 1484000

data2 = pd.read_csv(filename, sep='\t', parse_dates=['datetime'],
        comment='#',
        usecols=['site_no','datetime','166684_00065','166686_00060'])
data2.columns = ['Site','Date','GageHeight','Discharge']
data2.loc[0] = 'NaN'
startdata2 = data2['Date'][data2.index[1]]
enddata2 = data2['Date'][data2.index[-1]]
df2 = pd.DataFrame(data=data2)

headerss = ['Site','GageHeight','Discharge']
for i in headerss:
        df2[i] = df2[i].astype('float')

PlotDischarge(df2, sitenum)
#%%
#===========================================
filename = 'Data/01483700.txt'
sitenum = 1483700 

data3 = pd.read_csv(filename, sep='\t', parse_dates=['datetime'],
        comment='#',
        usecols=['site_no','datetime',
        '69413_00060','69414_00065'])
data3.columns = ['Site','Date','Discharge','GageHeight']
data3.loc[0] = 'NaN'
startdata3 = data3['Date'][data3.index[1]]
enddata3 = data3['Date'][data3.index[-1]]
df3 = pd.DataFrame(data=data3)

headerss = ['Site','Discharge','GageHeight']
for i in headerss:
        df3[i] = df3[i].astype('float')

PlotDischarge(df3, sitenum)
#%%
import io
import requests
urlname = "https://nwis.waterdata.usgs.gov/usa/nwis/uv/?cb_00010=on&cb_00060=on&cb_00065=on&cb_00095=on&cb_00300=on&cb_00400=on&cb_62619=on&cb_72255=on&format=rdb&site_no=01484085&period=&begin_date=2006-11-15&end_date=2019-05-20"
s=requests.get(urlname).content

data4 = pd.read_csv(io.StringIO(s.decode('utf-8')), sep='\t', 
        parse_dates=['datetime'],
        comment='#',
        usecols=['site_no','datetime','69431_00065',
        '213117_72137','69424_00010','69425_00095',
        '69426_00400','69427_00300','212549_72255',
        '69429_00060', '246397_62619'])
data4.columns = ['Site','Date', 'GageHeight',
        'DischargeFiltered','Temperature',
        'SpecificConductivity','pH','DO','MeanVelocity',
        'Discharge', 'EstuarySurface']
data4.loc[0] = 'NaN'
startdata4 = data4['Date'][data4.index[1]]
enddata4 = data4['Date'][data4.index[-1]]
df4 = pd.DataFrame(data=data4)
df4.set_index('Date',inplace=True)
headerss = ['Site', 'GageHeight',
        'DischargeFiltered','Temperature',
        'SpecificConductivity','pH','DO','MeanVelocity',
        'Discharge', 'EstuarySurface']
for i in headerss:
        df4[i] = df4[i].astype('float')