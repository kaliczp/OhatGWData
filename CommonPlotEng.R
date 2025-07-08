gwcolors <- c("#4575b4", # blueish
              "#d73027", # dark
              "#f46d43", # lighter
              "#fdae61" # lightest
              )

OriLocaleTim <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
produce <- "pdf" # or "png"
if(produce == "png") {
png("Fig2GWOhat12.png", width = 190, height = 60, units = "mm", pointsize = 7, res = 300)
} else {
pdf("Fig2GWOhat12.pdf", width = 190 / 25.4, height = 60 / 25.4, pointsize = 7)
}
par(mar = c(2.6, 4.1, 0.1, 0.1), mgp = c(2.5,1,0), las = 1, mgp = c(3.2,1,0))
plot.zoo(ohat1.xts['/2023-12-31'], xaxt = "n", xlab ="", ylab = "h [m]", xaxs = "i",
         ylim = c(-5.05,-3.8), type = "n")
grid(nx = NA, ny = NULL)
lines(as.zoo(ohat1.xts), lwd = 2, col = gwcolors[2])
lines(as.zoo(ohat2jav.xts), lwd = 2, col = gwcolors[3])
timeaxtics <- seq(as.POSIXct("2021-07-01"), as.POSIXct("2023-09-01") , by = "month")
axis(1, at = timeaxtics, labels = FALSE)
par(mgp = c(2.5, 0.4, 0))
axis.POSIXct(1, at = timeaxtics + 15*24*60*60, tcl = 0, cex.axis = 0.8, format = "%b")
par(mgp = c(2.5, 1.6, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-11-15", "2022-06-30", "2023-04-01")), tcl = 0, cex.axis = 0.8, format = "%Y")
legend("bottomleft", c("Ohat1", "Ohat2"), lwd = 2, col = gwcolors[2:3], bg = "white")
dev.off()
Sys.setlocale("LC_TIME", OriLocaleTim)
