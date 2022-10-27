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
ohat122a21 <- smartbe("2022/Ohat1a21.TXT")
ohat1 <- rbind(ohat121a09, ohat121b27,ohat121c28,ohat122414mod,ohat122625, ohat122a21)
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
