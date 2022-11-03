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
