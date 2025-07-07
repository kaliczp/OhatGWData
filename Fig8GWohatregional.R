library(readxl)
OhatGWreg <- as.data.frame(read_excel("Adatok-FigS5Fig10AFig11.xlsx"))

library(xts)
GWreg <- xts(as.numeric(OhatGWreg[-(1:3),"FIG10A"]), as.Date(OhatGWreg[-(1:3), 1]))

Ohat1.mnth <- xts(as.numeric(OhatGWreg[735:765,11]), as.Date(OhatGWreg[735:765,10]))
Ohat2.mnth <- xts(as.numeric(OhatGWreg[739:765,12]), as.Date(OhatGWreg[739:765,10])) 

pdf("Fig8GWohatregional.pdf", width = 19/2.54, height = 12/2.54, pointsize = 9)
layout(matrix(c(1, 1, 2, 3), nrow = 2, byrow = TRUE))
par(las = 1, lwd = 0.5, mar = c(0,4.1,0,0), oma = c(2.6,0,2.6,0.3))
plot.zoo(GWreg['1978-12/'],
         type = "n", axes = FALSE,
         lwd = 2, col = GWcolors["active"],
         ylim = c(-6,0),
         xaxs = "i", yaxs = "i",
         xlab = "", ylab = "GW [m]"
         )
axis(2, lwd = 0.5, at = -5:-1)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
axis.Date(3, lwd = 0.4)
axis(3, at = as.Date(c(paste0(1979:2023, "-01-01"),"2023-12-15")), labels = NA, tcl = -0.3, lwd = 0.5)
lines(as.zoo(GWreg['1978-12/']),
         lwd = 2, col = GWcolors["active"],
         )
lines(as.zoo(Ohat2.mnth['2022/']), lwd = 3, col = GWcolors["reference"])
lines(as.zoo(Ohat1.mnth), lwd = 3, col = GWcolors["passive"])
text(as.Date("1979-11-02"), -0.5, "A", cex = 1.7)
lines(as.Date(paste0(c(1979,1987),"-01-01")),c(-5,-5), col = "white", lwd = 5, lend = "butt")
legend("bottomleft", legend = c("regional mean GW", "Ohat1", "Ohat2"),
       col = GWcolors[c("active","passive","reference")],
       lwd = 2,
       bty = "n")
lines(as.Date(c("2022-05-01","2022-08-31")),c(-5.4,-5.4), lwd = 3, lend = "butt", col = "#FF1111")
text(as.Date("2022-05-31"), -5.7, "B")
text(as.Date("2023-05-31"), -5.7, "C")
lines(as.Date(c("2023-05-01","2023-08-31")),c(-5.4,-5.4), lwd = 3, lend = "butt", col = "#FF1111")
plot(index(slopeDatnona2022),
     coredata(slopeDatnona2022)[,1], ylim = c (0,3),
     xaxt ="n", yaxt = "n",
     xlab = "", ylab = "Recharge [mm/day]", pch = 16, col = "lightgray")
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
axis(2, lwd = 0.5)
axis.Date(1, index(slopeDatnona2022), lab = FALSE, lwd = 0.5)
axis.Date(1, at = as.Date(paste(2022,5:8,15, sep = "-")), format = "%Y-%m", tcl = 0, lwd = 0.4)
lines(slope2022.low, lwd = 2, col = "#FF1111"
      )
text(as.Date("2022-05-02"), 2.7, "B", cex = 1.7)
par(mar=c(0,0,0,2.5))
plot(index(slopeDatnona2023),
     coredata(slopeDatnona2023)[,1], ylim = c (0,3),
     yaxt = "n",
     xlab = "", ylab = "Recharge [mm/day]", xaxt ="n", pch = 16, col = "lightgray")
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
axis(4, lwd = 0.5)
axis.Date(1, index(slopeDatnona2023), lab = FALSE, lwd = 0.5)
axis.Date(1, at = as.Date(paste(2023,5:8,15, sep = "-")), format = "%Y-%m", tcl = 0, lwd = 0.4)
lines(slope2023.low, lwd = 2, col = "#FF1111"
      )
text(as.Date("2023-05-02"), 2.7, "C", cex = 1.7)
dev.off()
