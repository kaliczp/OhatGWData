library(readxl)
CropYield <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx"))
as.numeric(as.matrix((CropYield[2:12,])))

CropYield.clLo <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx",range="A2:K13"))

par(mfrow = c(1,2), las = 2, mar = c(0,0,0,0), oma = c(3.1,3.1,1.1,1.1))
barplot(t(as.matrix(CropYield.clLo[,2:4])), beside = TRUE, col = GWcolors, ylim = c(0,13), names.arg = 2000:2010)
box()
