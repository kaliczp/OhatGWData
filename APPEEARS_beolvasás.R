##APPEEARS adatok PET, ET

mod = read.csv("ohat2-0-MOD16A3GF-061-results.csv")
mod2 = read.csv("Ohat-MOD16A2-061-results.csv")
xts(mod2$MOD16A2_061_PET_500m,as.Date(mod2$Date))
mod2PET.xts=xts(mod2$MOD16A2_061_PET_500m,as.Date(mod2$Date))

mod2$Date <- as.Date(mod2$Date, format = "%Y-%m-%d")
mod2ET.xts <- xts(mod2$MOD16A2_061_ET_QC_500m, order.by = mod2$Date)



# Az xts objektum visszaalakítása dataframe-é
mod2PET_dataframe <- data.frame(Date = index(mod2PET.xts), Value = coredata(mod2PET.xts))
mod2PET_dataframe$Value <- gsub("\\.", ",", format(mod2PET_dataframe$Value, scientific = FALSE))

mod2ET_dataframe <- data.frame(Date = index(mod2ET.xts), Value = coredata(mod2ET.xts))
mod2ET_dataframe$Value <- gsub("\\.", ",", format(mod2ET_dataframe$Value, scientific = FALSE))

# CSV fájl mentése
write.table(mod2PET_dataframe, "mod2PET.csv", row.names = FALSE, sep = ";", col.names = TRUE, quote=FALSE)
write.table(mod2ET_dataframe, "mod2ET.csv", row.names = FALSE, sep = ";", col.names = TRUE, quote=FALSE)
