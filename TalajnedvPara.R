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

## Talajnedvesség -- ez nem működik -- valahogy bele kéne rakni a talajnedv.xts-be a station.name-t is, hogy utána tudjunk négy különböző görbét rajzolni
Talajnedv.xts <- xts(data_Egyek[data_Egyek$parameter == "Talajnedvesség", "value", "station.name"], as.POSIXct(data_Egyek[data_Egyek$parameter == "Talajnedvesség", "date"]))
plot(Talajnedv.xts))