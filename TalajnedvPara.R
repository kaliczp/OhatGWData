## Hagytam a Talaned_paratart mappában, amiben adtad. Csinálni kell és áttenni a fájlokat.
data_Egyek <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Egyek.txt.txt", dec = ".")
data_Egyek <- rbind(data_Egyek, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Egyek.txt.txt", dec = "."))
data_Kunmadaras <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Kunmadaras.txt.txt", dec = ".")
data_Kunmadaras <- rbind(data_Kunmadaras, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Kunmadaras.txt.txt", dec = "."))
data_Görbehaza <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Görbehaza.txt.txt", dec = ".")
data_Görbehaza <- rbind(data_Görbehaza, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Görbehaza.txt.txt", dec = "."))
data_Szentistvan <- read.csv2("Talajnedv_paratart/2022-05-01-06-30-Paratart_talajnedv_Szentistvan.txt.txt", dec = ".")
data_Szentistvan <- rbind(data_Szentistvan, read.csv2("Talajnedv_paratart/2023-07-01-08-31-Paratart_talajnedv_Szentistvan.txt.txt", dec = "."))
