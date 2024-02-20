## Hagytam a Talajnedv_paratart mappában, amiben adtad. Csinálni kell és áttenni a fájlokat.
data_Egyek <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Egyek.txt.txt", dec = ".")
data_Egyek <- rbind(data_Egyek, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Egyek.txt.txt", dec = "."))
data_Kunmadaras <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Kunmadaras.txt.txt", dec = ".")
data_Kunmadaras <- rbind(data_Kunmadaras, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Kunmadaras.txt.txt", dec = "."))
data_Görbehaza <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Görbehaza.txt.txt", dec = ".")
data_Görbehaza <- rbind(data_Görbehaza, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Görbehaza.txt.txt", dec = "."))
data_Szentistvan <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Szentistvan.txt.txt", dec = ".")
data_Szentistvan <- rbind(data_Szentistvan, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Szentistvan.txt.txt", dec = "."))

## Relatív páratartalom
library(xts)
Humidity_Egyek.xts <- xts(data_Egyek[data_Egyek$parameter == "Relatív páratartalom", "value"], as.POSIXct(data_Egyek[data_Egyek$parameter == "Relatív páratartalom", "date"]))
plot(Humidity_Egyek.xts)
plot(Humidity_Egyek.xts['2023'])
plot(Humidity_Egyek.xts['2023-07'])
plot(Humidity_Egyek.xts['2023-07-10'])
write.zoo(Humidity_Egyek.xts, "Humidity_Egyek.csv", sep = ";", dec = ".")
Daily_Humidity_Egyek.xts <- apply.daily(Humidity_Egyek.xts, mean)
plot(Daily_Humidity_Egyek.xts)
write.zoo(Daily_Humidity_Egyek.xts, "Daily_Humidity_egyek.csv", sep=";", dec=",")

## Talajnedvesség -- ez nem működik -- valahogy bele kéne rakni a talajnedv.xts-be a station.name-t is, hogy utána tudjunk négy különböző görbét rajzolni
## Szerintem először a szintekkel kell megküzeni. Pl.:
# Egyek
TalajnLevels <- c("10 cm", "20 cm", "30 cm", "45 cm", "60 cm", "75 cm")
EgyekTalajnedv.df <- data.frame(D10 = numeric(3000), D20 = numeric(3000), D30 = numeric(3000), D45 = numeric(3000), D60 = numeric(3000), D75 = numeric(3000))
for(tti in 1:length(TalajnLevels)){
    EgyekTalajnedv.df[,tti] <- data_Egyek[data_Egyek$parameter == "Talajnedvesség" & data_Egyek$level == TalajnLevels[tti], "value"]
}
Talajnedv.xts <- xts(EgyekTalajnedv.df, as.POSIXct(data_Egyek[data_Egyek$parameter == "Talajnedvesség" & data_Egyek$level ==TalajnLevels[1] , "date"]))
plot(Talajnedv.xts)
plot(Talajnedv.xts['2023'])

#Szentistvan
TalajnLevels <- c("10 cm", "20 cm", "30 cm", "45 cm", "60 cm", "75 cm")
SzentistvanTalajnedv.df <- data.frame(D10 = numeric(3000), D20 = numeric(3000), D30 = numeric(3000), D45 = numeric(3000), D60 = numeric(3000), D75 = numeric(3000))
for(tti in 1:length(TalajnLevels)){
  SzentistvanTalajnedv.df[,tti] <- data_Szentistvan[data_Szentistvan$parameter == "Talajnedvesség" & data_Egyek$level == TalajnLevels[tti], "value"]
}
Szentistvan.xts <- xts(SzentistvanTalajnedv.df, as.POSIXct(data_Szentistvan[data_Szentistvan$parameter == "Talajnedvesség" & data_Szentistvan$level ==TalajnLevels[1] , "date"]))
plot(Szentistvan.xts)
plot(Szentistvan.xts['2023'])
