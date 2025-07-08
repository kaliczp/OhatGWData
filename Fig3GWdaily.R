library(readxl)
GW_daily <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx", sheet = "GW_daily", skip = 1))
names(GW_daily) <- c("Date",
                     paste(rep(c("shall", "medi", "deep"),each=3),
                           c("reference","passive","active"),
                           sep = "_")
                     )
GW_daily$Date <- as.Date(GW_daily$Date)

GWcolors <- c(
    reference = "#8d8d8d",
    passive = "#ffd500",
    active = "#00c3ff")

AverageDepth <- data.frame(Mean =
                               c(1.26,
                                 1.26 - 0.18,
                                 1.26 - 0.43,
                                 2.44,
                                 2.44 - 0.31,
                                 2.44 - 0.63,
                                 3.99,
                                 3.99 - 0.31,
                                 3.99 - 0.81),
                           SD =
                               c(0.38,
                                 0.22,
                                 0.26,
                                 0.31,
                                 0.31,
                                 0.29,
                                 0.3,
                                 0.32,
                                 0.25)
                           )
AverageDepth$GWdepth <- rep(c("shall", "medi", "deep"), each = 3)

library(xts)
GW_daily.xts <- xts(GW_daily[,-1], GW_daily[,1])
GW.akt <- -GW_daily.xts["2000/2010"] 
selectedYears <- as.Date(paste0(2000:2010,"-01-01"))

pdf("Fig3GWdaily.pdf", width = 9/2.54, height = 11/2.54, pointsize = 7)
layout(matrix(c(1,2,3,4,5,6), nrow = 3, byrow = TRUE), widths=c(8,1))
ttletter <- 1
par(las = 1, mar = c(0,0,0,0), oma=c(5.4,2.7,2.1,0.2), lwd = 0.5)
for(gwdepth in c("shall", "medi", "deep")){
    combiname <-  paste(gwdepth, "reference", sep = "_")
    plot.zoo(GW.akt[, combiname], ylim = c(-5,1), type = "n",
             axes = FALSE,
             xaxs = "i",
             xlab = "", ylab = "GWL"
             )
    grid(nx = NA, ny = NULL)
    for(gwtype in c("reference", "active", "passive")) {
        combiname <-  paste(gwdepth, gwtype, sep = "_")
        lines(as.zoo(GW.akt[, combiname]), col = GWcolors[gwtype], ylim = c(1,-5), lwd = 2)
    }
    ## Axes
    axis(2, lwd = 0.5)
    if(gwdepth == "shall" || gwdepth == "deep") {
        axside <- ifelse(gwdepth == "shall", 3, 1)
        axis.Date(axside, at= c(selectedYears, as.Date("2010-12-31")), labels = FALSE, lwd = 0.5)
        axis.Date(axside, at= selectedYears + 365/2, tck = 0, format = "%Y", mgp = c(3,0.4,0), lty = 0)
        if(gwdepth == "deep") {
            legend("bottom", inset = c(0, -0.33), legend = c("Reference", "Passive", "Active"),
                   bty = "n",
                   cex = 1.2,
                   col = GWcolors, lwd = 2, ncol = 3, xpd = NA)
            }
    }
    text(as.Date("2000-03-15"), 0.8, LETTERS[ttletter], font = 2)
    currentAve <- -AverageDepth[AverageDepth$GWdepth == gwdepth, c("Mean", "SD")]
    plot(currentAve[, "Mean"], type = "n",
         axes = FALSE,
         xlim = c(0.5,3.5), ylim = c(-5,1),
         xlab = "", ylab = "",
         )
    grid(nx = NA, ny = NULL)
    points(currentAve[, "Mean"],
           pch = 19,
           col = GWcolors
           )
    for(tti in 1:3) {
        lines(c(tti,tti),c(currentAve[tti, "Mean"]-currentAve[tti, "SD"],
                           currentAve[tti, "Mean"]+currentAve[tti, "SD"]),
              col = GWcolors[tti],
              lwd = 2)
    }
    box()
    ttletter <- ttletter + 1
}
dev.off()

