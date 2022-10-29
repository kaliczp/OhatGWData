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
ohat1 <- rbind(ohat121a09, ohat121b27,ohat121c28,ohat122414mod,ohat122625mod, ohat122a21mod)
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

### Teljes időszak plot vagy png vagy pdf
png(file = paste0("Ohat1/Ohatfull.png"), width = 15, height = 8, unit = "cm", res=300)

pdf(file = "Ohat1/Ohatfull.pdf", width = 100/2.54, height = 30/2.54)

par(mar = c(3.1, 3.1, 0.2, 0.2), mgp = c(2,1,0))
plot.zoo(ohat1.xts, xaxt = "n", xlab ="", ylab = "h [m]", lwd = 2, xaxs = "i")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2022-10-21") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
dev.off()

## https://github.com/kaliczp/Whitexts/blob/master/Whitexts.R
oh.w <- White(ohat1.xts['2021-07-01 23:50:00/2021-07-15'])
