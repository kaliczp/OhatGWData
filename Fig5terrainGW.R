SoilColor <- "#92745B"
library(readxl)
Terr1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "A2:B249", col_names = FALSE))
GW1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "D1:N125"))
GW1 <- GW1[, -c(3:5,9)] # Remove repeated and empty cols


plot(Terr1, axes = FALSE, type = "n",
     ylim = c(85.5, 90),
     xlab = "", ylab = "",
     xaxs = "i"
     )
## Terrain
lines(Terr1, lwd = 2, 
      col = SoilColor
      )
## Ref
lines(GW1[,1],GW1[,2], lwd = 2, col = GWcolors["reference"])
## Passive
lines(GW1[,1],GW1[,3], lwd = 2, col = GWcolors["passive"])
## Active
lines(GW1[,1],GW1[,6], lwd = 2, col = GWcolors["active"])
