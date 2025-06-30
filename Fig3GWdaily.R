library(readxl)
GW_daily <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx", sheet = "GW_daily", skip = 1))
names(GW_daily) <- c("Date",
                     paste(rep(c("shall", "medi", "deep"),each=3),
                           c("reference","passive","active"),
                           sep = "_")
                     )
GW_daily$Date <- as.Date(GW_daily$Date)

GWcolors <- c(
    ref = "#8d8d8d",
    active = "#00c3ff",
    passive = "#ffd500")

library(xts)
GW_daily.xts <- xts(GW_daily[,-1], GW_daily[,1])
GW.akt <- -GW_daily.xts["2000/2010"] 
selectedYears <- as.Date(paste0(2000:2010,"-01-01"))

pdf("Fig3GWdaily.pdf", width = 10/2.54, height = 15/2.54, pointsize = 10)
par(mfrow = c(3,1), las = 1,
    mar = c(0,4.1,0,0.3), oma = c(2.1,0,2.1,0))
plot.zoo(GW.akt$shall_reference, ylim = c(-5,1), type = "n",
         axes = FALSE,
         xaxs = "i",
         xlab = "", ylab = "GWL"
         )
grid(nx = NA, ny = NULL)
lines(as.zoo(GW.akt$shall_reference), col = GWcolors["ref"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$shall_active), col = GWcolors["active"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$shall_passive), col = GWcolors["passive"], ylim = c(1,-5), lwd = 2)
## Axes
axis(2)
axis.Date(3, at= c(selectedYears, as.Date("2010-12-31")), labels = FALSE)
axis.Date(3, at= selectedYears + 365/2, tck = 0, format = "%Y")
plot.zoo(GW.akt$medi_reference, ylim = c(-5,1), type = "n",
         axes = FALSE,
         xaxs = "i",
         xlab = "", ylab = "GWL"
         )
grid(nx = NA, ny = NULL)
lines(as.zoo(GW.akt$medi_reference), col = GWcolors["ref"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$medi_active), col = GWcolors["active"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$medi_passive), col = GWcolors["passive"], ylim = c(1,-5), lwd = 2)
## Axes
axis(2)
plot.zoo(GW.akt$deep_reference, ylim = c(-5,1), type = "n",
         axes = FALSE,
         xaxs = "i",
         xlab = "", ylab = "GWL"
         )
grid(nx = NA, ny = NULL)
lines(as.zoo(GW.akt$deep_reference), col = GWcolors["ref"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$deep_active), col = GWcolors["active"], ylim = c(1,-5), lwd = 2)
lines(as.zoo(GW.akt$deep_passive), col = GWcolors["passive"], ylim = c(1,-5), lwd = 2)
## Axes
axis(2)
axis.Date(1, at= c(selectedYears, as.Date("2010-12-31")), labels = FALSE)
axis.Date(1, at= selectedYears + 365/2, tck = 0, format = "%Y")
dev.off()
