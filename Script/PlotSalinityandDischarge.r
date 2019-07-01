## Plot salinity and discharge given siteNumber, parameterCd, startDate, and endDate. 
SC_D <- readNWISdv(siteNumber, parameterCd, startDate, endDate)#, statCd=statCd
SC_D <- renameNWISColumns(SC_D)
parameters <- names(SC_D)

#Information about the data frame attributes:
statInfo <- attr(SC_D, "statisticInfo")
variableInfo <- attr(SC_D, "variableInfo")
siteInfo <- attr(SC_D, "siteInfo")
parameterscodes <- variableInfo$variableCode

# Extract month and year and store in separate columns
SC_D$year <- format(SC_D$Date, format = "%Y")
SC_D$month <- format(SC_D$Date, format = "%m")

# equation of the line 
require(stats)
reg<-lm(SpecCond ~ Date, data = SC_D)
coeff=coefficients(reg)
eq = paste0("y = ", round(coeff[2],3), "x + ", round(coeff[1],1))

abc <- variableInfo$variableCode

# Plot
filename = paste("C:/Users/Chelsea/Documents/Projects/DelawareStream/",siteInfo$site_no,".png",sep="")
png(file = filename, width = 1000, height = 1000)

par(mar=c(5,5,5,5)) #sets the size of the plot window
plot(SC_D$Date, SC_D$SpecCond,ylab=variableInfo$variableName[which(abc == "00095")],xlab="" )
abline(reg,col="blue")
par(new=TRUE)
if ("72137" %in% abc){
  plot(SC_D$Date, SC_D$X_72137,col="red",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
  mtext(variableInfo$variableName[which(abc == "72137")],side=4,line=3,col="red")#variableInfo$variableDescription[1],side=4,line=3,col="red")
  legend("topleft", legend = c(variableInfo$unit[which(abc == "00095")],
                               variableInfo$unit[which(abc == "72137")]),
         col=c("black","red"),lty=c(NA,1),pch=c(1,NA),title = eq)
  } else if ("00060" %in% abc){
  plot(SC_D$Date, SC_D$X_00060,col="red",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
  mtext(variableInfo$variableName[which(abc == "00060")],side=4,line=3,col="red")#variableInfo$variableDescription[1],side=4,line=3,col="red")
  legend("topleft", legend = c(variableInfo$unit[which(abc == "00095")],
                               variableInfo$unit[which(abc == "00060")]),
         col=c("black","red"),lty=c(NA,1),pch=c(1,NA),title = eq)
  } else {
    dischargeUnit <- readNWISuv(siteNumber, "62620", 
                                startDate, endDate)
    dischargeUnit <- renameNWISColumns(dischargeUnit)
    dischargeUnit$year <- format(dischargeUnit$dateTime, format = "%Y")
    dischargeUnit$month <- format(dischargeUnit$dateTime, format = "%m")
    DUvariableInfo <- attr(dischargeUnit, "variableInfo")
    plot(dischargeUnit$dateTime, dischargeUnit$X_62620_Inst,col="red",type="l",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
    mtext(DUvariableInfo$variableName[which(DUvariableInfo$variableCode == "62620")],side=4,line=3,col="red")#variableInfo$variableDescription[1],side=4,line=3,col="red")
    legend("topleft", legend = c(variableInfo$unit[which(abc == "00095")],
                                 DUvariableInfo$unit[which(DUvariableInfo$variableCode == "62620")]),
           col=c("black","red"),lty=c(NA,1),pch=c(1,NA),title = eq)
    print(siteNumber)
  }


axis(4,col="red",col.axis="red")
title(paste(siteInfo$station_nm, siteInfo$site_no))
print("DONE")
dev.off()


