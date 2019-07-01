#StreamFunctions

#============================================
#Clean up dataframe with stream parameters
stream.cleandf <- function(df) {
  df <- renameNWISColumns(df)
  parameters <- names(df)
  # Extract month and year and store in separate columns
  df$year <- format(df$Date, format = "%Y")
  df$month <- format(df$Date, format = "%m")
  df$day <- format(df$Date, format = "%d")
  df
}

#============================================
#Find Trendline and plot line with equation
stream.trendline.equation <- function(x, y, df, color) {
  # equation of the line
  require(stats)
  reg<-lm(x ~ y, data = df)
  coeff=coefficients(reg)
  abline(reg,col=color)
  paste0("y = ", round(coeff[2],3), "x + ", round(coeff[1],1))
}

#============================================
#Clean up plot by making labels and legend
stream.PlotText <- function(df, parameter, eq) {
  variableInfo <- attr(df, "variableInfo")
  siteInfo <- attr(df, "siteInfo")
  mtext(variableInfo$variableDescription[which(variableInfo$variableCode == parameter)],
        side=4,line=3,col="black")
  legend("topleft", legend = c(variableInfo$unit[which(variableInfo$variableCode == "00095")],
                               variableInfo$unit[which(variableInfo$variableCode == parameter)]),
         col=c("red","black"),lty=c(NA,1),pch=c(1,NA),title = eq)
  axis(4,col="black",col.axis="black")
  title(paste(siteInfo$station_nm, siteInfo$site_no))
}

#============================================
#Clean up plot by making labels and legend
stream.PlotText.noeq <- function(df, parameter) {
  variableInfo <- attr(df, "variableInfo")
  siteInfo <- attr(df, "siteInfo")
  mtext(variableInfo$variableDescription[which(variableInfo$variableCode == parameter)],
        side=4,line=3,col="black")
  legend("topleft", legend = c(variableInfo$unit[which(variableInfo$variableCode == "00095")],
                               variableInfo$unit[which(variableInfo$variableCode == parameter)]),
         col=c("red","black"),lty=c(NA,1),pch=c(1,NA))
  axis(4,col="black",col.axis="black")
  title(paste(siteInfo$station_nm, siteInfo$site_no))
}

#============================================
#Find ocean water level instead of discharge
  stream.PlotOcean <- function(df, siteNumber, startDate, endDate) {
    dischargeUnit <- readNWISuv(siteNumber, "62620", 
                                startDate, endDate)
    dischargeUnit <- renameNWISColumns(dischargeUnit)
    dischargeUnit$year <- format(dischargeUnit$dateTime, format = "%Y")
    dischargeUnit$month <- format(dischargeUnit$dateTime, format = "%m")
    variableInfo <- attr(dischargeUnit, "variableInfo")
    plot(dischargeUnit$dateTime, dischargeUnit$X_62620_Inst,col="black",type="l",
         xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
    variableInfo <- attr(df, "variableInfo")
    variableInfo2 <- attr(dischargeUnit, "variableInfo")
    siteInfo <- attr(dischargeUnit, "siteInfo")
    mtext(variableInfo2$variableDescription[which(variableInfo2$variableCode == "62620")],
          side=4,line=3,col="black")
    legend("topleft", legend = c(variableInfo$unit[which(variableInfo$variableCode == "00095")],
                                 variableInfo2$unit[which(variableInfo2$variableCode == "62620")]),
           col=c("red","black"),lty=c(NA,1),pch=c(1,NA),title = eq)
    axis(4,col="black",col.axis="black")
    title(paste(siteInfo$station_nm, siteInfo$site_no))
    stream.trendline.equation(dischargeUnit$dateTime, dischargeUnit$X_62620_Inst, dischargeUnit, "blue")
  }
  
  #============================================
  # #Create a new figure file for the png
  # stream.newfigure <- function(fname) {
  #   filename = paste("C:/Users/Chelsea/Documents/Projects/DelawareStream/Figures/",fname,".png",sep="")
  #   png(file = filename, width = 1000, height = 1000)
  #   par(mar=c(5,5,5,5)) #sets the size of the plot window
  # }
  
  #============================================
  # #Plot specific conductivity
  # stream.SpCplot <- function(df) {
  #   variableInfo <- attr(df, "variableInfo")
  #    plot(df$Date, df$SpecCond,col="red",
  #        ylab=variableInfo$variableDescription[which(variableInfo$variableCode == "00095")],
  #        xlab="" )
  # }
  
  #============================================
  # #Plot discharge
  # stream.Dischargeplot <- function(df) {
  #   variableInfo <- attr(df, "variableInfo")
  #   if ("72137" %in% variableInfo$variableCode){
  #       x <- "72137"
  #       p.plot <- plot(df$Date, df$X_72137,col="black",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
  #   } else if ("00060" %in% variableInfo$variableCode){
  #       x <- "00060"
  #       p.plot <- plot(df$Date, df$X_00060,col="black",xaxt="n",yaxt="n",xlab="",ylab="",axes=FALSE)
  #   } else {
  #     print("ERROR")
  #   }
  #   mtext(variableInfo$variableDescription[which(variableInfo$variableCode == x)],
  #         side=4,line=3,col="black")#variableInfo$variableDescription[1],side=4,line=3,col="red")
  #   legend("topleft", legend = c(variableInfo$unit[which(variableInfo$variableCode == "00095")],
  #                                variableInfo$unit[which(variableInfo$variableCode == x)]),
  #          col=c("red","black"),lty=c(NA,1),pch=c(1,NA),title = eq)
  #   return(p.plot)
  # }
  