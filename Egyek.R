## Fájlnevek beolvasása
filenames <- dir("Egyek", patt = "csv")
## Csak csapadék
csapfilenames <- filenames[14:length(filenames)]
csap <- read.csv2(paste0("Egyek/", csapfilenames[1]))
## Az összes csapadék fájlra
for(tti in 2:length(csapfilenames)) {
    csap <- rbind(csap, read.csv2(paste0("Egyek/", csapfilenames[tti])))
}
## Dupla dátum kiszedése
csap <- csap[!duplicated(csap$date),]
## Idősor
csap.xts <- xts(csap$value, as.POSIXct(csap$date))
napi.csap <- apply.daily(csap.xts, function(x){sum(x, na.rm = TRUE)})
havi.csap <- apply.monthly(csap.xts, function(x){sum(x, na.rm = TRUE)})
write.zoo(napi.csap, "Egyek/csap.csv", sep = ";", dec = ",")
write.zoo(havi.csap, "Egyek/havicsap.csv", sep = ";", dec = ",")
