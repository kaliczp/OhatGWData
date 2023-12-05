min(ohat1.xts,ohat2jav.xts, na.rm = TRUE)
max(ohat1.xts,ohat2jav.xts, na.rm = TRUE)

png(file = "Ohat2/Ohat12.png", width = 14.3, height = 6.2, unit = "cm", pointsize = 10, res = 300)
par(mar = c(2.6, 3.6, 0.1, 0.1), mgp = c(2.5,1,0), las = 1)
plot.zoo(ohat1.xts, xaxt = "n", xlab ="", ylab = "h [m]", xaxs = "i",
         ylim = c(-5.05,-3.8), type = "n")
grid(nx = NA, ny = NULL)
lines(as.zoo(ohat1.xts), lwd = 2)
lines(as.zoo(ohat2jav.xts), xaxt = "n", xlab ="", ylab = "h [m]", lwd = 2, xaxs = "i", col = "blue")
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
par(mgp = c(2.5, 0.4, 0))
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
par(mgp = c(2.5, 1.6, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-11-15", "2022-06-30", "2023-04-01")), tcl = 0, cex.axis = 0.8, format = "%Y")
legend("bottomleft", c("Kút1", "Kút2"), lwd = 2, col = c("black","blue") )

dev.off()
