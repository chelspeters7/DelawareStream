#%%
# monkey patch
import pandas.tseries.converter
from matplotlib import dates
import datetime
import matplotlib.dates as mdates
#==================================
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