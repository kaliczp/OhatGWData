## Fájlok kigyűjtése
ttfiles21 <- dir("2021", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles22 <- dir("2022", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles23 <- dir("2023", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles24 <- dir("2024", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles <- c(paste(2021, ttfiles21, sep = "/"),
             paste(2022, ttfiles22, sep = "/"),
             paste(2023, ttfiles23, sep = "/"),
             paste(2024, ttfiles24, sep = "/"))
ttfiles <- ttfiles[-3] ## Április ua. mint december

## A fájlok beolvasása
ohat2 <- smartbe(ttfiles[1])
for(tti in 2:length(ttfiles))
    ohat2 <- rbind(ohat2, smartbe(ttfiles[tti]))

## Időbélyeg készítés
tttime <- ohat2[,1]
tttime <- gsub("\\.", "-", tttime)
tttime <- as.POSIXct(tttime)

## Idősor osztályú objektum
library(xts)
ohat2.xts  <- xts(ohat2[,2], tttime)
plot(ohat2.xts)

ohat2.xts['2022-06-25 09:50/2022-06-25 10:00'] <- NA

ohat2jav.xts <- ohat2.xts

###Adathiánnyal felülírni ezt a szakaszt
ohat2.xts['2022-06-25 09:00/2022-06-25 11:10']
-4.649 + 5.05

ohat2jav.xts['2022-04-01/2022-06-25 10:00'] <- ohat2jav.xts['2022-04-01/2022-06-25 10:00'] + 0.401
ohat2jav.xts['2022-04-14 09:00/2022-04-14 10:10'] <- NA
ohat2jav.xts['2021-12-28 12:30/2021-12-29'] <- NA
ohat2jav.xts['2021-11-27 11:30'] <- NA
-4.554 + 4.569
ohat2jav.xts['/2021-11-27 08:00'] <- ohat2jav.xts['/2021-11-27 08:00'] + 0.015
ohat2jav.xts['2022-10-21 10:10/2022-10-21 10:20'] <- NA
ohat2jav.xts['2022-12-21 13:40/2022-12-21 13:50'] <- NA # Eltolódik megnézni!
ohat2jav.xts['2023-06-24 12:30/2023-06-24 12:40'] <- NA
ohat2jav.xts['2024-06-20 12:30/2024-06-21 14:40'] <- NA
plot(ohat2jav.xts)

pdf(file = "Ohat2/Ohat2full.pdf", width = 100/2.54, height = 30/2.54)
par(mar = c(3.1, 3.1, 0.2, 0.2), mgp = c(2,1,0))
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 2, xaxs = "i", type = "n")
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2024-10-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
axis(1, at = timeaxtics, labels = FALSE)
timeyears <- as.Date(paste(2021:2024, "01-01", sep = "-"))
axis(1, as.POSIXct(timeyears), tck = 1, lab = F, col = "lightgray")
text(as.POSIXct(timeyears  + c(320, 180, 180, 110)), -5, 2021:2024, cex = 4, col = "gray")
text(as.POSIXct(as.Date("2021-12-01")),-3.95, "Ohat2", cex = 4, col = "gray")
lines(as.zoo(ohat2jav.xts), lwd = 2)
box()
dev.off()

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

jpeg(file = "Ohat2/Ohat2full2.0.jpg", width = 14.3, height = 7, unit = "cm", pointsize = 10, res = 300)

par(mar = c(3.1, 3.6, 0.6, 0.2), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", xaxs = "i", type = "n")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
grid(nx=NA, ny = NULL)
timeaxtics <- seq(as.POSIXct("2021-10-01"), as.POSIXct("2023-09-01") , by = "3 month")
axis(1, at = timeaxtics, labels = FALSE, tck = 1, col = 'lightgray')
axis(1, at = ISOdate(2022:2023, 1, 01,0), labels = FALSE, tck = 1)
lines(as.zoo(ohat2jav.xts), lwd = 1)
box()

dev.off()


## Kiürül
plot(ohat2jav.xts['2022-06-24/2022-06-26'])
## Mi ment le?
plot(ohat2jav.xts['2022-07-25/2022-08-03'])
plot(ohat2jav.xts['2023-07-12/2023-07-14'])
plot(ohat2jav.xts['2023-07-24/2023-07-26'])

pdf(file = "Ohat2/Ohat2erdekes.pdf", width = 100/2.54, height = 30/2.54)
par(mar = c(3.1, 3.1, 0.2, 0.2), mgp = c(2,1,0))
plot.zoo(ohat2jav.xts['2022-06-22/2022-09-30'], xaxt = "n", xlab ="", ylab = "h [m]", lwd = 2, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2022-10-02") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
dev.off()

jpeg(file = "Ohat2/Ohat2full.jpg", width = 16, height = 7, unit = "cm", pointsize = 10, res = 300)
par(mar = c(2.1, 3.6, 0.1, 0.1), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 1, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
dev.off()

png(file = "Ohat2/Ohat2full.png", width = 14.3, height = 6.2, unit = "cm", pointsize = 10, res = 300)
par(mar = c(2.6, 3.6, 0.1, 0.1), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 1, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2023-09-01") , by = "month")

axis(1, at = timeaxtics, labels = FALSE)
par(mgp = c(2.5, 0.4, 0))
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
par(mgp = c(2.5, 1.6, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-11-15", "2022-06-30", "2023-04-30")), tcl = 0, cex.axis = 0.8, format = "%Y")
dev.off()


## Amplitúdók
daily.max <- apply.daily(ohat2jav.xts, max)
daily.min <- apply.daily(ohat2jav.xts, min)
daily.amp <- daily.max - daily.min
daily.amp <- round(daily.amp[-length(daily.amp)],4)
daily.amp.date <- xts(coredata(daily.amp), as.Date(index(daily.amp)))
write.zoo(daily.amp.date, "Ohat2/ampli.csv", sep = ";", dec = ",")

## Napi átlag, kiírása excelbe
daily.mean.rech <- apply.daily(ohat2jav.xts,mean)
write.zoo(daily.mean.rech, "Ohat2/Napivízszint.csv", sep = ";", dec = ",")

## Havi átlag
monthly.mean <- apply.monthly(ohat2jav.xts['/2023-08'], function(x){mean(x, na.rm = TRUE)})
monthly.mean.date <- xts(coredata(monthly.mean), as.Date(index(monthly.mean)))
potlas <- xts(rep(NA,3),
              as.Date(paste0('2022-0',2:4,'-01')) - 1)
monthly.mean.date.jav <- c(monthly.mean.date, potlas)
monthly.mean.date.jav <- na.approx(monthly.mean.date.jav)
write.zoo(xts(round(coredata(monthly.mean.date.jav),2), index((monthly.mean.date.jav))-15*24*60*60), "Ohat2/MonthlyMean.csv", sep = ";", dec = ",")

