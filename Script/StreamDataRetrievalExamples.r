library(dataRetrieval)

siteNumbers <- c("01483700")#,"01484000") 

siteINFO <- readNWISsite(siteNumbers)

comment(siteINFO)

#======================================================================================
# This pulls out just the daily, mean data:
dailyDataAvailable <- whatNWISdata(siteNumbers,service="dv", statCd="00003")


parameterCd <- "00060" 
parameterINFO <- readNWISpCode(parameterCd)

#======================================================================================
# Choptank River near Greensboro, MD:
siteNumber <- "01491000"
parameterCd <- "00060"  # Discharge
startDate <- "2009-10-01"  
endDate <- "2012-09-30" 

discharge <- readNWISdv(siteNumber, 
                        parameterCd, startDate, endDate)
#======================================================================================
siteNumber <- "01491000"
parameterCd <- c("00010","00060")  # Temperature and discharge
statCd <- c("00001","00003")  # Mean and maximum
startDate <- "2012-01-01"
endDate <- "2012-05-01"

temperatureAndFlow <- readNWISdv(siteNumber, parameterCd, 
                                 startDate, endDate, statCd=statCd)

names(temperatureAndFlow)
temperatureAndFlow <- renameNWISColumns(temperatureAndFlow)
names(temperatureAndFlow)

#Information about the data frame attributes:
names(attributes(temperatureAndFlow))
statInfo <- attr(temperatureAndFlow, "statisticInfo")
variableInfo <- attr(temperatureAndFlow, "variableInfo")
siteInfo <- attr(temperatureAndFlow, "siteInfo")

par(mar=c(5,5,5,5)) #sets the size of the plot window

plot(temperatureAndFlow$Date, temperatureAndFlow$Wtemp_Max,
     ylab=variableInfo$parameter_desc[1],xlab="" )
par(new=TRUE)
plot(temperatureAndFlow$Date, temperatureAndFlow$Flow,
     col="red",type="l",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
axis(4,col="red",col.axis="red")
mtext(variableInfo$parameter_desc[2],side=4,line=3,col="red")
title(paste(siteInfo$station_nm,"2012"))
legend("topleft", variableInfo$param_units, 
       col=c("black","red"),lty=c(NA,1),pch=c(1,NA))


# Dissolved Nitrate parameter codes:
parameterCd <- c("00618","71851")
startDate <- "1985-10-01"
endDate <- "2012-09-30"

dfLong <- readNWISqw(siteNumber, parameterCd, 
                     startDate, endDate)
comment(dfLong)
# Or the wide return:
dfWide <- readNWISqw(siteNumber, parameterCd,
                     startDate, endDate, reshape=TRUE)

