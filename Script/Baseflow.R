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
siteNumber <- "01484080"
parameterCd <- "all"
startDate <- "2017-03-04"
endDate <- "2018-01-31" #"2019-06-01"

# Find salinity and discharge given siteNumber, parameterCd, startDate, and endDate. 
SC_D <- readNWISdv(siteNumber, parameterCd, startDate, endDate)
SC_D <- stream.cleandf(SC_D)
df <- data.frame("date" = SC_D$Date, "day" = SC_D$day, "month" = SC_D$month, "year" = SC_D$year,
                 "flow" = SC_D$X_72137, "hyear" = SC_D$year)
SC_D_info <- readNWISsite(siteNumber)

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
# Baseflow seperation

bf <- BaseflowSeparation(SC_D$X_72137, filter_parameter = 0.925, passes = 3)

# Plot the data
par(mar=c(5,5,5,5))
plot(SC_D$Date, SC_D$X_72137,col="black",type = "l",
     ylab=variableInfo$variableDescription[which(variableInfo$variableCode == "72137")],
     xlab="Date")
lines(SC_D$Date, bf$bt, col = "blue")
eq <- stream.trendline.equation(SC_D$Date, SC_D$X_72137, SC_D, "red")
eq2 <- stream.trendline.equation(SC_D$Date, bf$bt, SC_D, "gray")

require(stats)
reg<-lm(Date ~ X_72137, data = SC_D)
coeff=coefficients(reg)
abline(reg,col="red")
#abc = as.numeric(as.character(bf$qft)) + as.numeric(as.character(bf$bt))
#lines(SC_D$Date, abc, col = "green")
#par(new=TRUE)
#plot(SC_D$Date, SC_D$SpecCond,col="red",
#     type = "l",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)

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
