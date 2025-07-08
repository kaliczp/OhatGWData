library(readxl)
CropYield <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx"))
as.numeric(as.matrix((CropYield[2:12,])))

CropYield.clLo <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx",range="A2:K13"))
CropYield.siCl <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx",range="A16:K27"))
CropYield.loSa <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx",range="A30:K41"))

## Erroneous data removed
CropYield.clLo[9,4] <- NA
CropYield.siCl[9,4] <- NA
CropYield.loSa[c(7,9,11),4] <- NA

pdf("Fig7CropYield.pdf", width = 19/2.54, height = 12/2.54, pointsize = 9)
par(mfrow = c(3,3), las = 2, mar = c(2.4,0,0,0), oma = c(2.7,2.6,3.1,0.2), lwd = 0.5)
barplot(t(as.matrix(CropYield.clLo[,2:4])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), lwd = 0.5)
mtext("shallow GW", las = 1, line = 1)
mtext("clLo", at = -2.5, las = 1, font = 2)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.clLo[,2:4])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
box()
barplot(t(as.matrix(CropYield.clLo[,5:7])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
mtext("medium GW", las = 1, line = 1)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.clLo[,5:7])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
box()
barplot(t(as.matrix(CropYield.clLo[,8:10])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
mtext("deep GW", las = 1, line = 1)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.clLo[,8:10])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
## Rainfed
lines(c(3,4,NA,7,8,NA,11,12,NA,15,16,NA,19,20,NA,23,24,NA,27,28,NA,31,32,NA,35,36,NA,39,40,NA,43,44,NA),
      rep((CropYield.clLo[,11])[1:11], each = 3), lwd = 3)
box()
## 2nd row
barplot(t(as.matrix(CropYield.siCl[,2:4])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), lwd = 0.5)
mtext("siCl", at = -2.5, las = 1, font = 2)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.siCl[,2:4])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
box()
barplot(t(as.matrix(CropYield.siCl[,5:7])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.siCl[,5:7])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
box()
barplot(t(as.matrix(CropYield.siCl[,8:10])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.siCl[,8:10])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
## Rainfed
lines(c(3,4,NA,7,8,NA,11,12,NA,15,16,NA,19,20,NA,23,24,NA,27,28,NA,31,32,NA,35,36,NA,39,40,NA,43,44,NA),
      rep((CropYield.siCl[,11])[1:11], each = 3), lwd = 3)
box()
## 3rd row
barplot(t(as.matrix(CropYield.loSa[,2:4])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), lwd = 0.5)
mtext("loSa", at = -2.5, las = 1, font = 2)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.loSa[,2:4])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
box()
barplot(t(as.matrix(CropYield.loSa[,5:7])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.loSa[,5:7])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
legend("bottom", inset = c(0, -0.4),
       legend = c("Reference", "Passive", "Active", "Rainfed conditions"),
       bty = "n",
       cex = 1.2,
       col = c(GWcolors, 1) , lwd = 3, ncol = 4, xpd = NA)
box()
barplot(t(as.matrix(CropYield.loSa[,8:10])), beside = TRUE, col = NA, border = NA, ylim = c(0,13), axes = FALSE)
grid(nx=NA, ny = NULL, col="lightgray", lty = 1)
barplot(t(as.matrix(CropYield.loSa[,8:10])), border = NA, beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010, axes = FALSE, add = TRUE, mgp = c(3,0.2,0))
## Rainfed
lines(c(3,4,NA,7,8,NA,11,12,NA,15,16,NA,19,20,NA,23,24,NA,27,28,NA,31,32,NA,35,36,NA,39,40,NA,43,44,NA),
      rep((CropYield.loSa[,11])[1:11], each = 3), lwd = 3)
box()
dev.off()
