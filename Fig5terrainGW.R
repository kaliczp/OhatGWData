SoilColor <- "#99745B"
library(readxl)
Terr1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "A2:B249", col_names = FALSE))
names(Terr1) <- c("x","y")
GW1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "D1:N125"))
GW1 <- GW1[, -c(3:5,9)] # Remove repeated and empty cols

Terr2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "B2:C183", col_names = FALSE))
names(Terr2) <- c("x","y")
GW2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "F1:P92"))
GW2 <- GW2[, -c(3:5,9)] # Remove repeated and empty cols

Forest2 <- Terr2[Terr2[,1] < 255,]
Forest2poly <- rbind(Forest2 + data.frame(rep(0,nrow(Forest2)), rep(1, nrow(Forest2))),
                     Forest2[nrow(Forest2):1,]
                     )
# forest 966–2487
Forest3 <- Terr2[Terr2[,1] > 966 & Terr2[,1] < 2487,]
Forest3poly <- rbind(Forest3 + data.frame(rep(0,nrow(Forest3)), rep(1, nrow(Forest3))),
                     Forest3[nrow(Forest3):1,]
                     )


pdf("Fig5terrainGW.pdf", width = 19/2.54, height = 12/2.54, pointsize = 9)
par(mfrow = c(2,1), las = 1, mar = c(1.1,4.1,2.1,0.2), oma = c(3,0,0,0))
plot(Terr1, axes = FALSE, type = "n",
     ylim = c(85, 91),
     xlab = "", ylab = "",
     xaxs = "i", yaxs = "i"
     )
axis(1, lwd = 0.4)
axis(1, at = c(0,6271.4), labels = NA, tck = 0, lwd = 0.5)
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
## Soil background
polygon(rbind(Terr1, data.frame(x=c(6271.4,0),y=c(0,0))), col = "#BD9A7A", border = NA)
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
axis(1, at = c(seq(0,4000, by = 1000)), lwd = 0.4)
axis(1, at = c(0,4566), labels = NA, tck = 0, lwd = 0.5)
mtext("Horizontal distance [m]", side = 1, line = 2, outer = TRUE)
axis(2, lwd = 0.5)
mtext("Elevation [m a.s.l.]", side = 2, at = 93, line = 3, las = 0)
## Soil background
polygon(rbind(Terr2, data.frame(x=c(4565.6,0),y=c(0,0))), col = "#BD9A7A", border = NA)
grid(ny = NA, col="lightgray", lty = 1)
lines(rep(c(0,4566,NA),6), rep(88:93, each = 3), col="lightgray", lty = 1)
## Polygon to hide
polygon(c(4570,6272,6272,4570), c(86,86,93.2,93.2), col = "white", border = NA)
## Forests
lines(Forest2poly[1:nrow(Forest2)-1,], lwd = 5, col = "forestgreen")
polygon(Forest2poly,
        col = "forestgreen", border = NA)
lines(Forest3poly[3:nrow(Forest3)-1,], lwd = 5, col = "forestgreen")
polygon(Forest3poly,
        col = "forestgreen", border = NA)
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
