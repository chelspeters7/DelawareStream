# Extract and plot baseflow
library(dataRetrieval)
library(ggplot2)
library(forecast)
library(plyr)
library(dplyr)
require(stats)
library(lfstat)
setwd("C:/Users/Admin/Desktop/Chelsea/Projects/DelawareStream/Script")
setwd('..')
source("Script/StreamFunctions.R")
source("Script/BFI.r")
#==========================================================
# Download discharge data
siteNumber <- "01484085"
parameterCd <- "all"
startDate <- "2018-03-04"
endDate <- "2018-12-31" #"2019-06-01"

# Find salinity and discharge given siteNumber, parameterCd, startDate, and endDate. 
SC_D <- readNWISdv(siteNumber, parameterCd, startDate, endDate)
SC_D <- stream.cleandf(SC_D)
df <- data.frame("date" = SC_D$Date, "day" = SC_D$day, "month" = SC_D$month, "year" = SC_D$year,
                 "flow" = SC_D$X_72137, "hyear" = SC_D$year)

# Information about the data frame attributes:
statInfo <- attr(SC_D, "statisticInfo")
variableInfo <- attr(SC_D, "variableInfo")
siteInfo <- attr(SC_D, "siteInfo")
parameterscodes <- variableInfo$variableCode

# Plot the data
plot(SC_D$Date, SC_D$X_72137,col="black",type = "l",
     ylab=variableInfo$variableDescription[which(variableInfo$variableCode == "72137")],
     xlab="Date")

#==========================================================
# Baseflow seperation using the Lyne and Hollick filter
BFI_LH(SC_D$X_72137, alpha=0.925, passes=3, ReturnQbase=FALSE, n.reflect=30)




# https://rdrr.io/cran/lfstat/man/BFI.html
BFI(df)
abd <- data(ngaruroro)
x <- BFI(ngaruroro)
BFI(ngaruroro, breakdays = c("01/11","01/05"))
BFI(ngaruroro, year = 1991)
bfplot(ngaruroro, year = 1991)
BFI(lfobj, year = "any",breakdays = NULL, yearly = FALSE)

source("Script/HYSEP.r")
df2 = hysep(df$flow, df$date)
