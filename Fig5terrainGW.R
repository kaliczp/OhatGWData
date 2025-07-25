SoilColor <- "#99745B"
SoilBackground <- "#DCB591"
library(readxl)
Terr1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "A2:B249", col_names = FALSE))
names(Terr1) <- c("x","y")
GW1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "D1:N125"))
GW1 <- GW1[, -c(3:5,9)] # Remove repeated and empty cols

Terr2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "A2:C183", col_names = FALSE))
Terr2 <- Terr2[, -2]
names(Terr2) <- c("x","y")
GW2 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", sheet = 2, range = "E1:P92"))
GW2 <- GW2[, -c(2,4:5,10)] # Remove repeated and empty cols

# forest 966–2487
Forest1 <- Terr1[Terr1[,1] > 1981 & Terr1[,1] < 3600,]
Forest1poly <- rbind(Forest1 + data.frame(rep(0,nrow(Forest1)), rep(1, nrow(Forest1))),
                     Forest1[nrow(Forest1):1,]
                     )


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
par(mfrow = c(2,1), las = 1, mar = c(1.6,4.1,1.1,0.2), oma = c(1,0,0,0))
plot(Terr1, axes = FALSE, type = "n",
     ylim = c(85, 91),
     xlab = "", ylab = "",
     xaxs = "i", yaxs = "i"
     )
axis(1, lwd = 0.4, mgp = c(3, 0.5, 0))
axis(1, at = c(0,6271.4), labels = NA, tck = 0, lwd = 0.5)
axis(2, lwd = 0.5)
## Soil background
polygon(rbind(Terr1, data.frame(x=c(6271.4,0),y=c(0,0))), col = SoilBackground, border = NA)
grid(ny = NA, col="lightgray", lty = 1)
lines(rep(c(0, 6271.4,NA),6), rep(86:91, each = 3), col="lightgray", lty = 1)
lines(Forest1poly[3:nrow(Forest1)-1,], lwd = 5, col = "forestgreen")
polygon(Forest1poly,
        col = "forestgreen", border = NA)
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
axis(1, at = c(seq(0,4000, by = 1000)), lwd = 0.4, mgp = c(3, 0.5, 0))
axis(1, at = c(0,4566), labels = NA, tck = 0, lwd = 0.5)
mtext("Horizontal distance [m]", side = 1, line = 0, outer = TRUE)
axis(2, lwd = 0.5)
mtext("Elevation [m a.s.l.]", side = 2, at = 93, line = 3, las = 0)
## Soil background
polygon(rbind(Terr2, data.frame(x=c(0, 4565.6),y=c(87, 87))), col = SoilBackground, border = NA)
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
lines(GW2[,1],GW2[,4], lwd = 2, col = GWcolors["passive"])
## Active
lines(GW2[,1],GW2[,7], lwd = 2, col = GWcolors["active"])
legend("right", legend = c("Terrain elevation","Reference", "Passive", "Active", "Forest"),
       bty = "n",
       col = c(SoilColor, GWcolors, "forestgreen"), lwd = c(3,2,2,2,8), xpd = NA)
dev.off()
