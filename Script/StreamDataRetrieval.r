
library(dataRetrieval)
library(ggplot2)
library(forecast)
library(dplyr)
library(plyr)

#================================================
# Example
#sites <- whatNWISsites(bBox=c(-81.0,38.4,-74.9,39.8),parameterCd=c("00095","00065"),
 #                      hasDataTypeCd="dv", siteTypes ="ST") 
#sites_discharge <- c("01483700","01484000","01484080","01484085","01483500")
#siteNumbers <- c("01484080","01484085")
#siteNumbers <- sites$site_no
siteNumbers <- c("01484080","01484085")
siteNumbers <- c("01463500",
                 "01479000",
                 "01480065")
# ,
#                  "01481000",
#                  "01481500",
#                  "01482800",
#                  "01483177",
#                  "01484080",
#                  "01484272",
#                  "01484525",
#                  "01484680",
#                  "01493112")
parameterCd <- "all"#c("00060","00095","00065")#Discharge... "00095" is for Specific Conductivity
startDate <- "1980-01-01"
endDate <- "2019-06-01"
for (count in 1:length(siteNumbers)) {
  siteNumber = siteNumbers[count]
  source("C:/Users/Chelsea/Documents/Projects/DelawareStream/Script/PlotSalinityandDischarge.R")
  dev.off()
}

#+=============================================

# Transform to `ts` class
monthly_milk_ts <- ts(SC_D$Date, start = 1997, end = 2019, freq = 365)  # Specify start and end year, measurement frequency (monthly = 12)

# Decompose using `stl()`
monthly_milk_stl <- stl(monthly_milk_ts, s.window = "period")

# Generate plots
plot(monthly_milk_stl)  # top=original data, second=estimated seasonal, third=estimated smooth trend, bottom=estimated irregular element i.e. unaccounted for variation
monthplot(monthly_milk_ts, choice = "seasonal")  # variation in milk production for each month
seasonplot(monthly_milk_ts)






Averagedmonthlyflow <- ddply(SC_D, .(month,year), summarize,  meanflow=mean(Flow))
(seasonal <- ggplot(Averagedmonthlyflow, aes(x = month, y = meanflow, group = year)) +
    geom_line(aes(colour = year)) +
    theme_classic())






#par(new=TRUE)
plot(SC_D$Date, SC_D$Flow,
     col=c("black","red"),type="l",xlab="",ylab=variableInfo$parameter_desc[1])
#axis(4,col="red",col.axis="red")
mtext(variableInfo$parameter_desc[2],side=4,line=3,col="black")
title(paste(siteInfo$station_nm, siteInfo$site_no))
#legend("topleft", variableInfo$param_units, 
#       col=c("black","red"),lty=c(NA,1),pch=c(1,NA))

siteNumbers <- c("01483700","01484000")
siteNumbers <- c("1463500",
                  "1479000",
                  "1480065",
                  "1481000",
                  "1481500",
                  "1482800",
                  "1483177",
                  "1484080",
                  "1484272",
                  "1484525",
                  "1484680",
                  "1493112")
siteNumbers <- c("01463500",
                 "01477800",
                 "01478000",
                 "01478245",
                 "01478650",
                 "01479000",
                 "01479197",
                 "01479820",
                 "01480000",
                 "01480015",
                 "01480095",
                 "01481000",
                 "01481500",
                 "01483153",
                 "01483155",
                 "01483165",
                 "01483170",
                 "01483200",
                 "01483500",
                 "01483670",
                 "01483700",
                 "01484000",
                 "01484018",
                 "01484050",
                 "01484080",
                 "01484084",
                 "01484085",
                 "01484100",
                 "01484270",
                 "01484500",
                 "01484525",
                 "01484534",
                 "01484600",
                 "01484654",
                 "01484668",
                 "01484695",
                 "01485000",
                 "01485500",
                 "01486000",
                 "01486500",
                 "01487000",
                 "01487060",
                 "01487150",
                 "01487195",
                 "01487500",
                 "01487698",
                 "01488500",
                 "01490000",
                 "01491000",
                 "01491500",
                 "01492500",
                 "01493000",
                 "01493112",
                 "01493500",
                 "01494150",
                 "01495000")

for (count in 1:57) {
  siteNumber <- siteNumbers[count]
  siteINFO <- readNWISsite(siteNumber)
  parameterCd <- c("00060")# discharge
  startDate <- "1980-01-01"
  endDate <- "2019-05-01"
  
  SC_D <- readNWISdv(siteNumber, parameterCd, 
                     startDate, endDate)#, statCd=statCd
  SC_D <- renameNWISColumns(SC_D)
  names(SC_D)
  
  #Information about the data frame attributes:
  #names(attributes(SC_D))
  statInfo <- attr(SC_D, "statisticInfo")
  variableInfo <- attr(SC_D, "variableInfo")
  siteInfo <- attr(SC_D, "siteInfo")
  
  filename = paste("C:/Users/Chelsea/Documents/Projects/DelawareStream/Figures/Discharge/",siteInfo$site_no,".png",sep="")
  png(file = filename, width = 1000, height = 1000)
  
  par(mar=c(5,5,5,5)) #sets the size of the plot window
  plot(SC_D$Date, SC_D$Flow,
       col="black",type="l",ylab=variableInfo$variableDescription, xlab="Date")
  #axis(4,col="red",col.axis="red")
  mtext(variableInfo$parameter_desc[2],side=4,line=3,col="black")
  title(paste(siteInfo$station_nm, siteInfo$site_no))
  
  dev.off()
}  
  
  
  


