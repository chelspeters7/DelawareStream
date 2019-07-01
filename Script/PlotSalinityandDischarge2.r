library(dataRetrieval)
library(ggplot2)
library(forecast)
library(dplyr)
library(plyr)
require(stats)
source("C:/Users/Chelsea/Documents/Projects/DelawareStream/Script/StreamFunctions.R")
source("C:/Users/Chelsea/Documents/Projects/DelawareStream/Script/BFI.r")

siteNumbers <- c("01484085", 
                 "01484080","01463500",
                 "01479000","01480065")

parameterCd <- "all"
startDate <- "1980-01-01"
endDate <- "2019-06-01"

for (count in 1:length(siteNumbers)) {
  # Determine site number
  siteNumber = siteNumbers[count]
  
  # Plot salinity and discharge given siteNumber, parameterCd, startDate, and endDate. 
  SC_D <- readNWISdv(siteNumber, parameterCd, startDate, endDate)
  SC_D <- stream.cleandf(SC_D)
  
  #Information about the data frame attributes:
  statInfo <- attr(SC_D, "statisticInfo")
  variableInfo <- attr(SC_D, "variableInfo")
  siteInfo <- attr(SC_D, "siteInfo")
  parameterscodes <- variableInfo$variableCode

  # Plot
  filename = paste("C:/Users/Chelsea/Documents/Projects/DelawareStream/Figures/",siteInfo$site_no,".png",sep="")
  png(file = filename, width = 1000, height = 1000)
  par(mar=c(5,5,5,5)) #sets the size of the plot window

  if("00095" %in% variableInfo$variableCode){
    plot(SC_D$Date, SC_D$SpecCond,col="red",
         ylab=variableInfo$variableDescription[which(variableInfo$variableCode == "00095")],
         xlab="" )
    eq = stream.trendline.equation(SC_D$SpecCond, SC_D$Date, SC_D, "red")
    par(new=TRUE)
  }
  
  if ("72137" %in% variableInfo$variableCode){
    plot(SC_D$Date, SC_D$X_72137,col="black",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
    stream.PlotText(SC_D, "72137", eq)
    eq1 = stream.trendline.equation(SC_D$X_72137, SC_D$Date, SC_D, "black")
  } else if ("00060" %in% variableInfo$variableCode){
    plot(SC_D$Date, SC_D$Flow,col="black",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
    stream.PlotText(SC_D, "00060", eq)
    eq1 = stream.trendline.equation(SC_D$Flow, SC_D$Date, SC_D, "black")
  } else {
    stream.PlotOcean(SC_D, siteNumber, startDate, endDate)
    print(siteNumber)
  }
  
  print("DONE")
  dev.off()
}

