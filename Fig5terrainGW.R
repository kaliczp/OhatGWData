SoilColor <- "#99745B"
library(readxl)
Terr1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "A2:B249", col_names = FALSE))
GW1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "D1:N125"))
GW1 <- GW1[, -c(3:5,9)] # Remove repeated and empty cols

Terr2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "B2:C183", col_names = FALSE))
GW2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "F1:P92"))
GW2 <- GW2[, -c(3:5,9)] # Remove repeated and empty cols


pdf("Fig5terrainGW.pdf", width = 19/2.54, height = 12/2.54, pointsize = 7)
par(mfrow = c(2,1), las = 1, mar = c(1.1,4.1,2.1,0.2), oma = c(3,0,0,0))
plot(Terr1, axes = FALSE, type = "n",
     ylim = c(85, 91),
     xlab = "", ylab = "",
     xaxs = "i", yaxs = "i"
     )
axis(1, lwd = 0.5)
axis(2, lwd = 0.5)
## Forest
lines(Terr1[Terr1[,1] > 1981 & Terr1[,1] < 3600,] + 0.26,
      lwd = 11, col = "forestgreen")
lines(Terr1[Terr1[,1] > 1981 & Terr1[,1] < 3600,] + 0.08,
      lwd = 3, col = "forestgreen")
## Lower white mask
lines(Terr1[Terr1[,1] > 1981 & Terr1[,1] < 3600,]- 0.13, col = "white", lwd = 4)
lines(Terr1[Terr1[,1] > 1981 & Terr1[,1] < 3600,]- 0.28, col = "white", lwd = 6)
lines(c(1975,1975),c(88,89), col = "white", lwd = 6)
grid(col="lightgray", lty = 1)
## Forest patch
lines(c(3000,3000),c(89,89.85), col = "forestgreen", lwd = 1.5)
lines(c(2160,2219),c(89,89), col = "forestgreen", lwd = 1.5, lend = 1)
lines(c(3550,3620),c(89,89), col = "forestgreen", lwd = 1.5, lend = 1)
lines(c(3064,3135),c(90,90), col = "forestgreen", lwd = 1.5)
## Terrain
lines(Terr1, lwd = 3, 
      col = SoilColor
      )
## Ref
lines(GW1[,1],GW1[,2], lwd = 2, col = GWcolors["reference"])
## Passive
lines(GW1[,1],GW1[,3], lwd = 2, col = GWcolors["passive"])
## Active
lines(GW1[,1],GW1[,6], lwd = 2, col = GWcolors["active"])
### Lower plot
plot(Terr1, axes = FALSE, type = "n",
     ylim = c(87, 93),
     xlab = "", ylab = "",
     xaxs = "i", yaxs = "i"
     )
## Forest
lines(Terr2[Terr2[,1] < 255,] + 0.26,
      lwd = 11, col = "forestgreen")
lines(Terr2[Terr2[,1+] < 255,] + 0.08,
      lwd = 3, col = "forestgreen")
axis(1, at = c(seq(0,4000, by = 1000)), lwd = 0.4)
axis(1, at = c(0,4566), labels = NA, tck = 0, lwd = 0.5)
mtext("Horizontal distance [m]", side = 1, line = 2, outer = TRUE)
axis(2, lwd = 0.5)
mtext("Elevation [m a.s.l.]", side = 2, at = 93, line = 3, las = 0)
grid(ny = NA, col="lightgray", lty = 1)
lines(rep(c(0,4566,NA),6), rep(88:93, each = 3), col="lightgray", lty = 1)
## Polygon to hide
polygon(c(4570,6272,6272,4570), c(86,86,93.2,93.2), col = "white", border = NA)
## Terrain
lines(Terr2, lwd = 3, 
      col = SoilColor
      )
## Ref
lines(GW2[,1],GW2[,2], lwd = 2, col = GWcolors["reference"])
## Passive
lines(GW2[,1],GW2[,3], lwd = 2, col = GWcolors["passive"])
## Active
lines(GW2[,1],GW2[,6], lwd = 2, col = GWcolors["active"])
legend("right", legend = c("Terrain elevation","Reference", "Passive", "Active", "Forest"),
       bty = "n",
       col = c(SoilColor, GWcolors, "forestgreen"), lwd = c(3,2,2,2,8), xpd = NA)
dev.off()
