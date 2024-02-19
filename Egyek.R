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
plot(csapall.xts)

napi.csap <- apply.daily(csapall.xts, function(x){sum(x, na.rm = TRUE)})
havi.csap <- apply.monthly(csapall.xts, function(x){sum(x, na.rm = TRUE)})
write.zoo(napi.csap, "Egyek/csap.csv", sep = ";", dec = ",")
write.zoo(havi.csap, "Egyek/havicsap.csv", sep = ";", dec = ",")
plot(havi.csap, type="h")


## Weekly sum
napi.csap.Date <- xts(coredata(napi.csap), as.Date(index(napi.csap)))
EgyekCsweek.xts <- period.apply(napi.csap.Date, endpoints(napi.csap.Date, "weeks"), sum)

write.zoo(cbind(DerCsweek.xts,EgyekCsweek.xts), "Egyek/DebrEgyekHeti.csv", sep = ";", dec = ",")
plot(DerCsweek.xts - EgyekCsweek.xts)

##Egyek, Görbeháza, Kunmadaras, Szentistván relatív páratartalom és talaj nedvességtartalom összehasonlításai
install.packages("ggplot2")
install.packages("dplyr")
install.packages("anytime")
library(anytime)
library(ggplot2)
library(dplyr)

data_Egyek <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Egyek.txt.txt", dec = ".")
data_Kunmadaras <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Kunmadaras.txt.txt", dec = ".")
data_Görbehaza <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Görbehaza.txt.txt", dec = ".")
data_Szentistvan <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Szentistvan.txt.txt", dec = ".")

merged_data <- bind_rows(
  mutate(data_Egyek, station.name = "Egyek"),
  mutate(data_Kunmadaras, station.name = "Kunmadaras"),
  mutate(data_Görbehaza, station.name = "GĂ¶rbehĂˇza"),
  mutate(data_Szentistvan, station.name = "SzentistvĂˇn")
)

# Rajzolj grafikont
ggplot(merged_data, aes(x = date, y = value, color = station.name)) +
  geom_line() +
  labs(x = "Date", y = "Talajnedvesség", color = "Terület", title = "Talajnedvesség változása az idő függvényében") +
  theme_minimal()

## Újabb kísérlet

# Átlagoljuk az adatokat háromnaponta
data_Egyek <- data_Egyek %>%
  mutate(date = anytime(date)) %>%
  group_by(station.name, as.numeric(as.Date(date) - min(as.Date(date))) %/% 3) %>%
  summarize(avg_talajnedv = mean(value))

data_Kunmadaras <- data_Kunmadaras %>%
  mutate(date = anytime(date)) %>%
  group_by(station.name, as.numeric(as.Date(date) - min(as.Date(date))) %/% 3) %>%
  summarize(avg_talajnedv = mean(value))

data_Görbehaza <- data_Görbehaza %>%
  mutate(date = anytime(date)) %>%
  group_by(station.name, as.numeric(as.Date(date) - min(as.Date(date))) %/% 3) %>%
  summarize(avg_talajnedv = mean(value))

data_Szentistvan <- data_Szentistvan %>%
  mutate(date = anytime(date)) %>%
  group_by(station.name, as.numeric(as.Date(date) - min(as.Date(date))) %/% 3) %>%
  summarize(avg_talajnedv = mean(value))

# Egyesítjük az adatokat

merged_data <- bind_rows(data_Egyek, data_Kunmadaras, data_Görbehaza, data_Szentistvan)

# Rajzoljuk meg a grafikont
ggplot(data = merged_data, aes(x = as.Date(date), y = avg_talajnedv, color = station.name)) +
  geom_line() +
  labs(x = "Date", y = "Talajnedvesség", color = "Terület", title = "Talajnedvesség változása az idő függvényében") +
  theme_minimal()


ggplot(data = merged_data, aes(x = anytime(date), y = avg_talajnedv, color = station.name)) +
  geom_line() +
  labs(x = "Date", y = "Talajnedvesség", color = "Terület", title = "Talajnedvesség változása az idő függvényében") +
  theme_minimal()

Paratart_talajnedv22 <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Egyek.txt.txt", dec = ".")
Paratart_talajnedv22 <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Kunmadaras.txt.txt", dec = ".")
Paratart_talajnedv22 <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Görbehaza.txt.txt", dec = ".")
Paratart_talajnedv22 <- read.csv2("2022-05-01-06-30-Paratart_talajnedv_Szentistvan.txt.txt", dec = ".")

Paratart_talajnedv23 <- read.csv2("2023-07-01-08-31-Paratart_talajnedv_Egyek.txt.txt", dec = ".")
Paratart_talajnedv23 <- read.csv2("2023-07-01-08-31-Paratart_talajnedv_Kunmadaras.txt.txt", dec = ".")
Paratart_talajnedv23 <- read.csv2("2023-07-01-08-31-Paratart_talajnedv_Görbehaza.txt.txt", dec = ".")
Paratart_talajnedv23 <- read.csv2("2023-07-01-08-31-Paratart_talajnedv_Szentistvan.txt.txt", dec = ".")

