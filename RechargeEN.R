produce <- "pdf" # or "png"
if(produce == "png") {
png("FigRechargeOhat.png", width = 90, height = 110, units = "mm", pointsize = 7, res = 300)
} else {
pdf("FigRechargeOhat.pdf", width = 90 / 25.4, height = 110 / 25.4, pointsize = 7)
}
par(mar = c(3.1,4.1,0.6,4.1), mfrow = c(2,1), las = 1)
plot(index(slopeDatnona2022),
     coredata(slopeDatnona2022)[,1], ylim = c (0,3),
     xlab = "", ylab = "Recharge [mm/day]", xaxt ="n", pch = 16, col = "lightgray")
axis.Date(1, index(slopeDatnona2022), lab = FALSE)
axis.Date(1, at = as.Date(paste(2022,5:8,15, sep = "-")), format = "%Y-%m", tcl = 0)
lines(slope2022.low, lwd = 2, col = "#FF1111"
      )
text(as.Date("2022-05-02"), 2.9, "a", cex = 1.7)
plot(index(slopeDatnona2023),
     coredata(slopeDatnona2023)[,1], ylim = c (0,3),
     xlab = "", ylab = "Recharge [mm/day]", xaxt ="n", pch = 16, col = "lightgray")
axis.Date(1, index(slopeDatnona2023), lab = FALSE)
axis.Date(1, at = as.Date(paste(2023,5:8,15, sep = "-")), format = "%Y-%m", tcl = 0)
lines(slope2023.low, lwd = 2, col = "#FF1111"
      )
text(as.Date("2023-05-02"), 2.9, "b", cex = 1.7)
dev.off()
