library(dataRetrieval)
library(ggplot2)
library(forecast)
library(plyr)
library(dplyr)
require(stats)
setwd("C:/Users/Admin/Desktop/Chelsea/Projects/DelawareStream/Script")
setwd('..')
source("Script/StreamFunctions.R")
source("Script/BFI.r")

# Discharge sites
sitesd <- whatNWISsites(bBox=c(-77.9,36.5,-72.6,41.0), 
                       parameterCd=c("00060"),
                       hasDataTypeCd="dv")
dis <- sitesd$site_no

# Salinity sites
sitess <- whatNWISsites(bBox=c(-77.9,36.5,-72.6,41.0), 
                       parameterCd=c("00095"),
                       hasDataTypeCd="dv")
spc <- sites$site_no
# Good sites
sites <- spc[(spc %in% dis)]

parameterCd <- "all"
startDate <- "1950-01-01"
endDate <- "2019-06-01"

for (count in 2:4) {
  # Determine site number
  siteNumber = sites[count]
  
  # Find salinity and discharge given siteNumber, parameterCd, startDate, and endDate. 
  SC_D <- readNWISdv(siteNumber, parameterCd, startDate, endDate)
  SC_D <- stream.cleandf(SC_D)
  
  #Information about the data frame attributes:
  statInfo <- attr(SC_D, "statisticInfo")
  variableInfo <- attr(SC_D, "variableInfo")
  siteInfo <- attr(SC_D, "siteInfo")
  parameterscodes <- variableInfo$variableCode
  
  if("00095" %in% variableInfo$variableCode){
    # Output to CSV
    df <- data.frame("No" = SC_D$site_no, "Date" = SC_D$Date, "Flow" = SC_D$Flow, "SpC" = SC_D$SpecCond)
    filename = paste("Data/",siteInfo$site_no,".csv",sep="")
    write.csv(df, file = filename)
    
    # Plot
    par(mar=c(5,5,5,5)) #sets the size of the plot window
    plot(SC_D$Date, SC_D$SpecCond,col="red",
           ylab=variableInfo$variableDescription[which(variableInfo$variableCode == "00095")],
           xlab="" )
    par(new=TRUE)
    plot(SC_D$Date, SC_D$Flow,col="black",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
    stream.PlotText.noeq(SC_D, "00060")
  }
}


