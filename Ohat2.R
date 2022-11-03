## Fájlok kigyűjtése
ttfiles21 <- dir("2021", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles22 <- dir("2022", patt = "Ohat2[1-9abc][0-9][0-9].TXT")
ttfiles <- c(paste(2021, ttfiles21, sep = "/"), paste(2022, ttfiles22, sep = "/"))

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
