## Fájlok kigyűjtése
ttfiles21 <- dir("2021", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles22 <- dir("2022", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles <- c(paste(2021, ttfiles21, sep = "/"), paste(2022, ttfiles22, sep = "/"))
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

ohat2.xts['2022-06-25 09:00/2022-06-25 11:10']
-4.649 + 5.05

ohat2jav.xts['2022-04-01/2022-06-25 10:00'] <- ohat2jav.xts['2022-04-01/2022-06-25 10:00'] + 0.401
ohat2jav.xts['2022-04-14 09:00/2022-04-14 10:10'] <- NA
ohat2jav.xts['2021-12-28 12:30/2021-12-29'] <- NA
ohat2jav.xts['2021-11-27 11:30'] <- NA
-4.554 + 4.569
ohat2jav.xts['/2021-11-27 08:00'] <- ohat2jav.xts['/2021-11-27 08:00'] + 0.015
plot(ohat2jav.xts)

pdf(file = "Ohat2/Ohat2full.pdf", width = 100/2.54, height = 30/2.54)
par(mar = c(3.1, 3.1, 0.2, 0.2), mgp = c(2,1,0))
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 2, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2022-10-21") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
dev.off()


## Kiürül
plot(ohat2jav.xts['2022-06-24/2022-06-26'])
## Mi ment le?
plot(ohat2jav.xts['2022-07-25/2022-08-03'])

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
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2022-10-21") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
dev.off()

png(file = "Ohat2/Ohat2full.png", width = 14.3, height = 6.2, unit = "cm", pointsize = 10, res = 300)
par(mar = c(2.6, 3.6, 0.1, 0.1), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat2jav.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 1, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-11-01"), as.POSIXct("2022-10-21") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
par(mgp = c(2.5, 0.4, 0))
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
par(mgp = c(2.5, 1.6, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-11-15", "2022-05-30")), tcl = 0, cex.axis = 0.8, format = "%Y")
dev.off()
