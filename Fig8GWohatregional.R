library(readxl)
OhatGWreg <- as.data.frame(read_excel("Adatok-FigS5Fig10AFig11.xlsx"))

library(xts)
GWreg <- xts(as.numeric(OhatGWreg[-(1:3),"FIG10A"]), as.Date(OhatGWreg[-(1:3), 1]))

par(las = 1, lwd = 0.5)
plot.zoo(GWreg['1979/'],
         lwd = 2, col = GWcolors["active"],
         ylim = c(-6,0),
         xaxs = "i", yaxs = "i",
         xaxt = "n",
         xlab = "", ylab = "GW [m]"
         )
axis.Date(3, tck = 0)
axis(3, at = as.Date(paste0(1979:2023, "-01-01")), labels = NA)
