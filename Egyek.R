## Fájlnevek beolvasása
## Csak csapadék
csapfilenames <- homfilenames <- dir("Egyek", patt = "^cs2")
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

## Hőmérséklet és pára
homfilenames <- dir("Egyek", patt = "^2")
ttraw <- read.csv2(paste0("Egyek/", homfilenames[2]))
## Hőmérséklet
hom <- ttraw[ttraw$parameter == "Levegőhőmérséklet",]
## Pára
para <- ttraw[ttraw$parameter == "Relatív páratartalom",]
## Az összes fájlra
for(tti in 2:length(homfilenames)) {
ttraw <- read.csv2(paste0("Egyek/", homfilenames[tti]))
hom <- rbind(hom, ttraw[ttraw$parameter == "Levegőhőmérséklet",])
para <- rbind(para, ttraw[ttraw$parameter == "Relatív páratartalom",])
}
## Dupla dátum kiszedése
hom <- hom[!duplicated(hom$date),]
para <- para[!duplicated(para$date),]
## Idősor
hom.xts <- xts(hom$value, as.POSIXct(hom$date))
para.xts <- xts(para$value, as.POSIXct(para$date))
## Napi és havi átlag
napi.hom <- apply.daily(hom.xts, function(x){mean(x, na.rm = TRUE)})
havi.hom <- apply.monthly(hom.xts, function(x){mean(x, na.rm = TRUE)})
write.zoo(napi.hom, "Egyek/hom.csv", sep = ";", dec = ",")
write.zoo(havi.hom, "Egyek/havihom.csv", sep = ";", dec = ",")
napi.para <- apply.daily(para.xts, function(x){mean(x, na.rm = TRUE)})
havi.para <- apply.monthly(para.xts, function(x){mean(x, na.rm = TRUE)})
write.zoo(napi.para, "Egyek/para.csv", sep = ";", dec = ",")
write.zoo(havi.para, "Egyek/havipara.csv", sep = ";", dec = ",")

## A maradék egybe fájlok
egybefilenames <- dir("Egyek", patt = "txt")
ttraw <- read.csv2(paste0("Egyek/", egybefilenames[1]))
## Hőmérséklet
hom <- ttraw[ttraw$parameter == "Levegőhőmérséklet",]
## Csapadék
csap <- ttraw[ttraw$parameter == "Csapadek60",]
## Az összes fájlra
for(tti in 2:length(egybefilenames)) {
ttraw <- read.csv2(paste0("Egyek/", egybefilenames[tti]))
hom <- rbind(hom, ttraw[ttraw$parameter == "Levegőhőmérséklet",])
csap <- rbind(csap, ttraw[ttraw$parameter == "Csapadek60",])
}

## Adathiányok törlése ELLENŐRIZNI, hogy mi ment ki!
csap <- csap[!is.na(csap$value),]
hom[!is.na(hom$value),]
## Dupla dátum kiszedése
hom <- hom[!duplicated(hom$date),]
csap <- csap[!duplicated(csap$date),]

## Idősor
hom.xts <- xts(hom$value, as.POSIXct(hom$date))
csapuj.xts <- xts(csap$value, as.POSIXct(csap$date))
csapall.xts <- c(csap.xts["/2022-10-30"], csapuj.xts["2022-10-31/"])

##Csapadékgörbék
plot(csap.xts)

napi.csap <- apply.daily(csapall.xts, function(x){sum(x, na.rm = TRUE)})
havi.csap <- apply.monthly(csapall.xts, function(x){sum(x, na.rm = TRUE)})
write.zoo(napi.csap, "Egyek/csap.csv", sep = ";", dec = ",")
write.zoo(havi.csap, "Egyek/havicsap.csv", sep = ";", dec = ",")
plot(havi.csap, type="h")
