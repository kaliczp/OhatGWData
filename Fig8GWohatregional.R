library(readxl)
OhatGWreg <- as.data.frame(read_excel("Adatok-FigS5Fig10AFig11.xlsx"))

library(xts)
GWreg <- xts(as.numeric(OhatGWreg[-(1:3),"FIG10A"]), as.Date(OhatGWreg[-(1:3), 1]))

Ohat1.mnth <- xts(as.numeric(OhatGWreg[735:765,11]), as.Date(OhatGWreg[735:765,10]))
Ohat2.mnth <- xts(as.numeric(OhatGWreg[739:765,12]), as.Date(OhatGWreg[739:765,10])) 

pdf("Fig8GWohatregional.pdf", width = 19/2.54, height = 12/2.54, pointsize = 9)
layout(matrix(c(1, 1, 2, 3), nrow = 2, byrow = TRUE))
par(las = 1, lwd = 0.5, mar = c(0,0,0,0), oma = c(2.6,2.6,2.6,0.3))
plot.zoo(GWreg['1978-12/'],
         type = "n", axes = FALSE,
         lwd = 2, col = GWcolors["active"],
         ylim = c(-6,0),
         xaxs = "i", yaxs = "i",
         xlab = "", ylab = "GW [m]"
         )
axis(2, lwd = 0.5)
axis.Date(3, lwd = 0.4)
axis(3, at = as.Date(paste0(1979:2023, "-01-01")), labels = NA, tcl = -0.3, lwd = 0.5)
lines(as.zoo(GWreg['1978-12/']),
         lwd = 2, col = GWcolors["active"],
         )
lines(as.zoo(Ohat1.mnth), lwd = 3, col = GWcolors["passive"])
plot(c(0,1), c(0,1), axes = FALSE, type = "l")
plot(c(0,1), c(0,1), axes = FALSE, type = "l")
dev.off()
