.First  <- function(){Sys.setenv(TZ = "UTC"); require("xts")}
Sys.setenv(TZ = "UTC")
library(xts)
## https://github.com/kaliczp/smartbe függvényét használva

## Beolvasás
ohat121a09 <- smartbe("2021/Ohat1a09.TXT")
ohat121b27 <- smartbe("2021/Ohat1b27.TXT")
ohat121b27[2,2] <- NA
ohat121c28 <- smartbe("2021/Ohat1c28.TXT")
ohat121c28[1,2] <- NA
ohat122414 <- smartbe("2022/Ohat1414.TXT")
ohat122414mod <- ohat122414
ohat122414mod[c(1,nrow(ohat122414mod)),2] <- NA
ohat122414mod$Measure <- ohat122414mod$Measure + 0.157
ohat122625 <- smartbe("2022/Ohat1625.TXT")
ohat122625mod <- ohat122625[-(1:5),]
ohat122625mod$Measure <- ohat122625mod$Measure + 0.145
ohat122a21 <- smartbe("2022/Ohat1a21.TXT")
ohat122a21mod <- ohat122a21
ohat122a21mod$Measure  <- ohat122a21mod$Measure + 0.46
ohat122c21 <- smartbe("2022/Ohat1c21.TXT")
## 5.345-4.88 = 0.465
ohat122c21mod <- ohat122c21
ohat122c21mod$Measure <- ohat122c21mod$Measure + 0.465
ohat123624 <- smartbe("2023/Ohat1624.TXT")
ohat123624mod <- ohat123624
ohat123624mod$Measure <- ohat123624mod$Measure + 0.465
ohat123901 <- smartbe("2023/Ohat1901.TXT")
ohat123901mod <- ohat123901
ohat123901mod$Measure <- ohat123901mod$Measure + 0.465
ohat124621 <- smartbe("2024/Ohat124621.TXT")
ohat124621mod <- ohat124621
## ohat124621mod$Measure <- ohat124621mod$Measure + 0.465
ohat124a04 <- smartbe("2024/Ohat1a04.TXT")
ohat124a04mod <- ohat124a04
## ohat124621mod$Measure <- ohat124621mod$Measure + 0.465
ohat125416 <- smartbe("2025/Ohat1416.TXT")
ohat125416mod <- ohat125416
## ohat124621mod$Measure <- ohat124621mod$Measure + 0.465
ohat1 <- rbind(ohat121a09, ohat121b27,ohat121c28,ohat122414mod,ohat122625mod, ohat122a21mod, ohat122c21mod, ohat123624mod, ohat123901mod, ohat124621mod,ohat124a04mod,ohat125416mod)
plot(ohat1$Measure, type = "l")

## Időbélyeg készítés
tttime <- ohat1[,1]
tttime <- gsub("\\.", "-", tttime)
tttime <- as.POSIXct(tttime)
plot(tttime,ohat1$Measure, type = "l")

## Idősor osztályú objektum
library(xts)
ohat1.xts  <- xts(ohat1[,2], tttime)
plot(ohat1.xts)

## Alulcsordulások adathiánnyá alakítása
ohat1.xts['2022-06-16 08:40/2022-06-25 09:00'] <- NA
ohat1.xts['2022-08-05 10:00/2022-09-22 19:30'] <- NA
ohat1.xts['2022-10-21 08:10/2022-10-21 08:20'] <- NA
ohat1.xts['2022-08-05 09:50/2022-09-22 19:40'] <- NA
ohat1.xts['2022-10-21 08:00/2022-10-21 08:50'] <- NA
ohat1.xts['2022-12-21 11:00/2022-12-22 13:00'] <- NA
ohat1.xts['2023-06-23 20:00/2023-06-25 08:00'] <- NA
ohat1.xts['2023-06-25/'] <- ohat1.xts['2023-06-25/'] + 0.4
ohat1.xts['2023-09-01 17:10:00/2023-09-01 17:20:00'] <- NA
## korrigálni szeptembertől?

plot(ohat1.xts['2022-10-20/2022-10-21'])

plot(ohat1.xts, main = "", lwd = 1)

### Teljes időszak plot vagy png vagy pdf
png(file = paste0("Ohat1/Ohatfull.png"), width = 15, height = 8, unit = "cm", res=300)

pdf(file = "Ohat1/Ohatfull.pdf", width = 100/2.54, height = 30/2.54)

par(mar = c(3.1, 3.6, 0.2, 0.2), mgp = c(2.5,1,0))
plot.zoo(ohat1.xts, xaxt = "n", xlab ="", ylab = "h [m]", xaxs = "i", type = "n")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
grid(nx=NA, ny = NULL)
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "3 month")
axis(1, at = timeaxtics, labels = FALSE, tck = 1, col = 'lightgray')
axis(1, at = ISOdate(2022:2023, 1, 01,0), labels = FALSE, tck = 1)
lines(as.zoo(ohat1.xts), lwd = 1)
box()

dev.off()

jpeg(file = "Ohat1/Ohatfull.jpg", width = 16, height = 7, unit = "cm", pointsize = 10, res = 300)

par(mar = c(3.1, 3.6, 0.6, 0.2), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat1.xts, xaxt = "n", xlab ="", ylab = "h [m]", xaxs = "i", type = "n")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
grid(nx=NA, ny = NULL)
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "3 month")
axis(1, at = timeaxtics, labels = FALSE, tck = 1, col = 'lightgray')
axis(1, at = ISOdate(2022:2023, 1, 01,0), labels = FALSE, tck = 1)
lines(as.zoo(ohat1.xts), lwd = 1)
box()

dev.off()


## Export full time-series
write.zoo(ohat1.xts, "Ohat1/Ohat1xts.csv", sep = ";", dec = ",")

## https://github.com/kaliczp/Whitexts/blob/master/Whitexts.R
oh.w <- White(ohat1.xts['2021-07-01 23:50:00/2021-07-15'], Sy = 0.134)

## 2021
idok <- seq(as.POSIXct("2021-06-23"), as.POSIXct("2021-11-01"), by = "7 days")
## 2022
idok <- seq(as.POSIXct("2022-05-06"), as.POSIXct("2022-06-17"), by = "7 days")
## 2022 második
idok <- seq(as.POSIXct("2022-06-25"), as.POSIXct("2022-08-05"), by = "7 days")


for(tti in 1:(length(idok)-1)) {
    starttime <- idok[tti]
    endtime <- idok[tti + 1]
    endtime.calc <- idok[tti + 1] + 24 * 60 * 60
    timewindow <- paste(starttime - 10*60, endtime.calc, sep = "/")
    aktfilename <- paste(starttime, endtime, sep = "_")
    oh.w <- White(ohat1.xts[timewindow], Sy = 0.134)
    ## pdf(file = paste0(aktfilename, ".pdf"), width = 16/2.54, height = 8/2.54)
    ## jpeg(file = paste0(aktfilename, ".jpg"), width = 16, height = 8, unit = "cm", res=300)
    png(file = paste0("Ohat1/",aktfilename, ".png"), width = 16, height = 8, unit = "cm", res=300)
    plot.White(oh.w)
    timeaxtics <- seq(starttime, endtime + 24*60*60, by = "day")
    axis(1, at = timeaxtics, lab = FALSE)
    axis.POSIXct(1, at = seq(starttime, endtime, by = "day") + 12*60*60, tcl = 0, cex.axis = 0.8)
    dev.off()
}

## S_{y0} 0.134 Meyboom default 0.5
## 2021
oh2021.w <- White(ohat1.xts['2021-06-23 23:50:00/2021-11-01'], Sy = 0.134, Meyboom = 0.5)
write.zoo(oh2021.w$result, "Ohat1/Ohat1.csv", sep = ";", dec = ",")

## 2022
oh2022.w <- White(ohat1.xts['2022-05-05 23:50:00/2022-06-15'], Sy = 0.134)
write.zoo(oh2022.w$result, "Ohat1/Ohat1_2022.csv", sep = ";", dec = ",")

## 2022 második
oh2022_2.w <- White(ohat1.xts['2022-06-26 23:50:00/2022-08-04'], Sy = 0.134)
write.zoo(oh2022_2.w$result, "Ohat1/Ohat1_2022_2.csv", sep = ";", dec = ",")
y
## 2022 második
oh2022_3.w <- White(ohat1.xts['2022-09-23 23:50:00/2022-10-20'], Sy = 0.134)
write.zoo(oh2022_3.w$result, "Ohat1/Ohat1_2022_3.csv", sep = ";", dec = ",")


## Amplitúdók
daily.max <- apply.daily(ohat1.xts, max)
daily.min <- apply.daily(ohat1.xts, min)
daily.amp <- daily.max - daily.min
daily.amp <- round(daily.amp[-length(daily.amp)],4)
daily.amp.date <- xts(coredata(daily.amp), as.Date(index(daily.amp)))
write.zoo(daily.amp.date, "Ohat1/ampli.csv", sep = ";", dec = ",")

## Daily average
daily.mean <- apply.daily(ohat1.xts, mean)
daily.mean.date <- xts(coredata(daily.mean), as.Date(index(daily.mean)))
write.zoo(daily.mean.date, "Ohat1/mean.csv", sep = ";", dec = ",")

## Monthly
monthly.mean <- apply.monthly(ohat1.xts['/2025-01'], function(x){mean(x, na.rm = TRUE)})
round(monthly.mean['2021-06/2023-12'],2)
